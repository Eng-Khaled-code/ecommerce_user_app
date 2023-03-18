import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/services/userServices/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../pl/body/utilities/references/user_ref.dart';

class EmailAndPasswordServices
{

   FirebaseAuth firebaseAuth=FirebaseAuth.instance;
   FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
   UserRef userRef=UserRef();

   Future<void> signInWithEmailAndPassword(String email, String password)async
   {

        UserCredential user= await firebaseAuth
             .signInWithEmailAndPassword(email: email, password: password);

   }

   Future<void> signUpWithEmailAndPassword({String? username, String? email, String? password,
     File? profilePicture}) async
   {

     UserCredential user= await firebaseAuth
       .createUserWithEmailAndPassword(email: email!, password: password!);

     String userImgUrl= await UserServices().uploadProfilePictureToStorage(profilePicture!,user.user!.uid);

     Map<String, dynamic> values = {
       "name": username,
       "photoURL": userImgUrl,
       "email": "$email",
       "user_id": user.user!.uid,
       "favList": ["garbageValue"]
     };

     await UserServices().addUser(data: values);
     await UserServices().setFavListToLocal( ["garbageValue"]);

   }


}