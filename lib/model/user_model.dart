
import 'package:firebase_auth/firebase_auth.dart';

import '../pl/body/utilities/references/user_ref.dart';

class UserModel {


  String? id;
  String? name;
  String? email;
  String? photoURL;
  List? favourateList;

  UserRef userRef=UserRef();
  UserModel({this.id, this.name, this.email, this.photoURL,this.favourateList});

  UserModel.emptyInstance();

  UserModel.fromSnapshoot(Map<String,dynamic> snapshot) {

    id = snapshot[userRef.userId];
    name = snapshot[userRef.name];
    email = snapshot[userRef.email];
    photoURL = snapshot[userRef.photoURL]??"no image";
    favourateList=snapshot[userRef.favList];
  }

  Map<String,dynamic> toMap(User user){
    return {
      userRef.name:user.displayName,
      userRef.email: user.email,
      userRef.userId: user.uid,
      userRef.photoURL:user.photoURL,
      userRef.favList: ["garbageValue"]
    };

  }

}
