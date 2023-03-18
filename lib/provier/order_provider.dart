import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/services/order_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
class OrderProvider with ChangeNotifier{

  bool loading=false;
  String? error;
  OrderServices _orderServices=OrderServices();
  Future<bool> addOrder({Map<String,dynamic>? data})async{
    try {
      loading=true;
      notifyListeners();

      await _orderServices.addOrder(data: data);
      notifyListeners();

      loading=false;
      notifyListeners();
      Fluttertoast.showToast(msg: "your order has placed successfully");

      return true;
    }on FirebaseException catch (e) {
      loading = false;
      Fluttertoast.showToast(msg:e.message!);
      notifyListeners();
      return false;
    }

  }

  Future<void> receivedOrder({String? orderId})async{
    try {
      loading=true;
      notifyListeners();

      await _orderServices.recievedOrder(orderId: orderId);

      Fluttertoast.showToast(msg: "Order has been Received,Confirmed");
      loading=false;
      notifyListeners();

    }on FirebaseException catch (e) {
      loading = false;
      Fluttertoast.showToast(msg:e.message! );
      notifyListeners();
    }

  }

  Stream<DocumentSnapshot<Map<String,dynamic>>> myStream({String? orderId}){
    Stream<DocumentSnapshot<Map<String,dynamic>>> _stream=FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get().asStream();
    return _stream;
  }
}