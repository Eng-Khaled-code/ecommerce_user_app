
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/user_model.dart';
class UsersList{

  Future<List<UserModel>> loadingUsersList() async {

    List<UserModel> list=[];
    await FirebaseFirestore.instance.collection("users").get().then((snapshot) {
      snapshot.docs.forEach((element) {
        list.add(UserModel.fromSnapshoot(element.data()));
      });
    });


    return list;
  }
}
