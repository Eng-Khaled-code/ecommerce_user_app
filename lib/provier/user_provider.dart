import 'dart:io';
import 'package:final_ecommerce/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/userServices/user_services.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth? _auth;
  Status status = Status.Uninitialized;
  UserModel? userData;

  UserServices userServices=UserServices();
  bool isLoading=false;
  bool signUpPage=false;
  File? profileImage;
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth!.authStateChanges().listen(onStatusChange);
  }

  setSignUpPage(bool goToSignUp)
  {
    signUpPage=goToSignUp;
    notifyListeners();
  }

  setProfileImage(File image)
  {
    profileImage=image;
    notifyListeners();
  }

  Future<void> googleSignIn() async {
    try {

      await userServices.googleSigningIn();

      status = Status.Authenticated;
      Fluttertoast.showToast(msg:"Log in successfully");
      notifyListeners();

    }on FirebaseException catch (e) {

      Fluttertoast.showToast(msg:"Log in With Google Failed, "  + e.message.toString(),toastLength: Toast.LENGTH_LONG);
      status = Status.Unauthenticated;
      notifyListeners();
    }
  }

   signInAndUpWithEmail({String? type, String? username, String? email, String? password,
     }) async {
    try {
      status = Status.Authenticating;
      notifyListeners();


      if(type=="sign in")
      await userServices.signInWithEmailAndPassword(email!, password!);
      else
      await userServices.signUpWithEmailAndPassword(email: email,password: password,username: username,profilePicture: profileImage);


      status = Status.Authenticated;
      notifyListeners();

      Fluttertoast.showToast(msg:"Log in successfully");

      }on FirebaseException catch (e) {

      status = Status.Unauthenticated;
      Fluttertoast.showToast(msg:"Log in Failed, "  + e.message.toString(),toastLength: Toast.LENGTH_LONG);
      notifyListeners();
    }
  }


  Future<void> signOut() {
    userServices.signOut();
    status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void>? onStatusChange(User? user) async {
    await Future.delayed(Duration(seconds: 2));

    if (user == null){
      status = Status.Unauthenticated;

    }
    else {
            try{

                      userData=await userServices.loadUserData(userId: user.uid);

                      List<String> favList=(userData!.favourateList??[""]).cast<String>();
                      userServices.setFavListToLocal( favList);

                      status = Status.Authenticated;

          } on FirebaseException catch(e){

                      status = Status.Unauthenticated;
                      Fluttertoast.showToast(msg: e.message!);
          }
       }


    notifyListeners();
 }


  Future<void> updateUserData({String? nickName,File? profileImage})async{
    try {
      isLoading=true;
      notifyListeners();

      await userServices.updateUserData(nickName: nickName,userId: userData!.id,profileImage: profileImage);
      userData=await userServices.loadUserData(userId: userData!.id);
      isLoading=false;
      notifyListeners();
      Fluttertoast.showToast(msg:"Updated successfully");

    }on FirebaseException catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg:e.message!);

    }
  }
}
