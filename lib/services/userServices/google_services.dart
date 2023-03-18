
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/user_model.dart';
import 'package:final_ecommerce/services/userServices/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../pl/body/utilities/references/user_ref.dart';


class GoogleServices
{

  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  UserRef userRef=UserRef();


  Future<void> googleSigningIn() async {

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential user=await firebaseAuth
        .signInWithCredential(credential);

    await signInWithCredMethod(credential: user);
  }

  Future<void> signInWithCredMethod({UserCredential? credential})async{

    User user=credential!.user!;

    //saving data to firestore becase this user is new
    if (! await isSignedInBefore(userId: user.uid))
    {

      Map<String, dynamic> data = UserModel().toMap(user);

      await UserServices().addUser(data: data);
      await UserServices().setFavListToLocal( ["garbageValue"]);


    }
    //else
    //{

      //return UserServices().loadUserData(userId: user.uid);

    //}


  }

  Future<bool> isSignedInBefore({String? userId})async {

    final QuerySnapshot querySnapshot = await firebaseFirestore
        .collection(userRef.collection)
        .where(userRef.userId, isEqualTo:userId)
        .get();

    if(querySnapshot.docs.length==0) return false;
    else return true;

  }




}