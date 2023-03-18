import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/user_model.dart';
import 'package:final_ecommerce/services/userServices/favourite_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'email_and_password_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'google_services.dart';

class UserServices extends GoogleServices with EmailAndPasswordServices,FavouriteServices
{


  Future<UserModel> loadUserData({String? userId})async {

    final QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(userRef.collection)
        .where(userRef.userId, isEqualTo:userId)
        .get();

    UserModel userData= UserModel.fromSnapshoot(querySnapshot.docs[0].data() as Map<String,dynamic>);

    return userData;
  }


  Future<void> addUser({Map<String,dynamic>? data}) async{
    await firebaseFirestore.collection(userRef.collection).doc(data![userRef.userId]).set(data);
  }

  Future<String> uploadProfilePictureToStorage(File profilePic,String userId) async {
    String imgFileName = userId;
    String userImageUrl="";

    try {
      Uint8List fileBytes = await profilePic.readAsBytes();


      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("profile images")
          .child(imgFileName);
      UploadTask storageUploadTask;
      if(kIsWeb) storageUploadTask= storageReference.putData(fileBytes);
      else storageUploadTask= storageReference.putFile(profilePic);

      TaskSnapshot storageTaskSnapshot = await storageUploadTask
          .whenComplete(() {});

      userImageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    }on FirebaseException catch(e)
    {
      print(e.message);
    }
    return userImageUrl;

  }

  Future<void> updateUserData({String? nickName,String? userId,File? profileImage})async {
    if (profileImage != null) {
      deleteOldImage(userId);

         String photoURL =await uploadProfilePictureToStorage(profileImage,userId!);
         Map<String,dynamic> data={
           userRef.photoURL: photoURL,
           userRef.name: nickName,
         };

        await firebaseFirestore.collection(userRef.collection).doc(userId).update(data);

    } else {
        await firebaseFirestore
          .collection(userRef.collection)
          .doc(userId)
          .update({userRef.name: nickName});
    }
  }

  void deleteOldImage(String? userId) async{

   String url= await FirebaseStorage.instance
        .ref()
        .child("profile images")
        .child(userId!)
        .getDownloadURL();

      if (url != "") {
        await FirebaseStorage.instance
            .ref()
            .child("profile images")
            .child(userId)
            .delete();
      }
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut();
    try{
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }catch(e){}

  }

}