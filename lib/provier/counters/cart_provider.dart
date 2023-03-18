
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/cart_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:final_ecommerce/services/cart_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider extends ChangeNotifier {

  double totalPrice=0;
  int totalItemCounter=0;
  int cardCounter=0;
  List<Map<String,dynamic>>? cartItems;
  bool loading=false;
  bool? inCardOrNot;

  int cartNumOfItems=1;

  CartServices _cartServices=CartServices();



  Future<void> addItemToCardList({Map<String,dynamic>? data,String? userId})async{
    try {
    loading=true;
    notifyListeners();

    await _cartServices.addItem(data: data,userId: userId);

    loading=false;
    Fluttertoast.showToast(msg:"added successfully");

    notifyListeners();

    }on FirebaseException catch (e) {
      loading = false;
      Fluttertoast.showToast(msg:e.message!);
      notifyListeners();
    }

  }

  Future<void> deleteItemFromCart({String? productId, String? userId}) async {
    try {
      loading = true;
      notifyListeners();

     await _cartServices.deleteItemFromCard(userId: userId,productId: productId);

        loading = false;
        notifyListeners();

      Fluttertoast.showToast(msg:"removed successfully");
    }on FirebaseException catch (e) {
      loading = false;
      Fluttertoast.showToast(msg:e.message!);
      notifyListeners();

    }
  }


  Future<void> deleteCartList({String? userId}) async {
    try {
      loading = true;
      notifyListeners();

      await _cartServices.deleteCartList(userId: userId);

      loading = false;
      notifyListeners();

      Fluttertoast.showToast(msg:"removed successfully");
    }on FirebaseException catch (e) {
      loading = false;
      notifyListeners();
      Fluttertoast.showToast(msg:e.message!);
    }
  }

  Future<void> updateItemCart({Map<String,dynamic>? data,String? userId}) async {
    try {
      loading = true;
      notifyListeners();

      await _cartServices.updateItemToCard(data: data,userId: userId);

      loading = false;
      notifyListeners();

      Fluttertoast.showToast(msg:"updated successfully");
    }on FirebaseException catch (e) {
      loading = false;
      notifyListeners();
      Fluttertoast.showToast(msg:e.message!);
    }
  }

  Future<void> loadTotalPrice({String? userId})async{
    totalPrice=await _cartServices.loadingCartTotalPrice(userId: userId);
    notifyListeners();

  }

  Future<void> loadTotalItemCount({String? userId})async{
    totalItemCounter=await _cartServices.loadingCartTotalItemCount(userId: userId);
    notifyListeners();
  }

  Future<void> loadingCartCounter({String? userId})async {
    cardCounter=await _cartServices.loadingCartCounter(userId: userId);
    notifyListeners();
  }

  Future<void> checkItem({String? userId,String? productId})async{
    inCardOrNot= await _cartServices.checkItem(userId: userId,productId :productId);
    notifyListeners();
  }

  Future<void> loadingCartItems({String? userId})async{

    cartItems=await _cartServices.loadingCartItems(userId: userId);
    notifyListeners();
  }

 numOfItemIncrement(int value){
    cartNumOfItems=cartNumOfItems+value;
    notifyListeners();
 }

 resetNumOfItems(){
    cartNumOfItems=1;
 }


  }
