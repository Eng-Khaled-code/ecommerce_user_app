import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/address_servicess.dart';

class AddressChange extends ChangeNotifier{

  int currentIndex=0;

  bool isLoading = false;

  AddressServices addressServices=AddressServices();

  setIndex(int index)
  {
    currentIndex=index;
    notifyListeners();
  }

 Future<void> addAddress({Map<String,dynamic>? data,String? userId})async{
   try {
     isLoading=true;
     notifyListeners();

     await addressServices.addAddress(data: data,userId: userId);

     isLoading=false;
     notifyListeners();
     Fluttertoast.showToast(msg:"Address added successfully");

   }on FirebaseException catch (e) {
     isLoading = false;
     notifyListeners();
     Fluttertoast.showToast(msg:e.message!);

   }
 }
}