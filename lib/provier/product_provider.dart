import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:final_ecommerce/model/product_model.dart';
import 'package:final_ecommerce/model/user_model.dart';
import 'package:final_ecommerce/provier/counters/user_list.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  int likeCounter = 0;
  List<UserModel>? users;
  List<ProductModel>? carasolList = [];

  String searchedValue="";
  String selectedCategory="All";

  ProductProvider() {
    loadingCarouselList();
    loadUsersList();
  }

  setCategory(String category){
    selectedCategory=category;
    notifyListeners();
  }

  setSearchedValue(String value){
    searchedValue=value;
    notifyListeners();
  }

  resetSearchAndCategory(){
    selectedCategory="All";
    searchedValue="";
    notifyListeners();
  }
  Future<void> loadUsersList() async {
    users = await UsersList().loadingUsersList();
    notifyListeners();
  }

  loadingCarouselList() async {
    List<ProductModel> carouselList1 = [];

    QuerySnapshot<Map<String,dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection("products")
        .orderBy("publishDate", descending: true)
        .limit(5)
        .get();

    querySnapshot.docs.forEach((element) {
      carouselList1.add(ProductModel.fromSnapshoot(element.data()));
    });


    carasolList=carouselList1;
    notifyListeners();
  }

  displayLikeCounter(String productName) async {
    List<String> favList;

    if(users!=null)
    users!.forEach((element) {
      favList = element.favourateList!.cast<String>();

      if (favList.contains(productName)) likeCounter++;
    });

    notifyListeners();
  }


}
