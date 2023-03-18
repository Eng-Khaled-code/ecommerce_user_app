import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/cart_item_model.dart';

import 'cart_services.dart';

class OrderServices{

  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<void>  addOrder({Map<String,dynamic>? data})async{

    await _firestore
        .collection("orders")
        .doc(data!["orderBy"] + data["orderTime"])
        .set(data).whenComplete(()async{
           await CartServices().deleteCartList(userId:data["orderBy"]);
    });
  }
  Future<void>  recievedOrder({String? orderId})async{

  await _firestore
      .collection("orders")
      .doc(orderId)
      .update({"isSuccess":"recived"});

}

}