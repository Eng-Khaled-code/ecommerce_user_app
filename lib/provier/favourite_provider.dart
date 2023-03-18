import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/userServices/favourite_services.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> favList=[];
  FavouriteServices favouriteServices=FavouriteServices();
  bool fav = false;
  bool isLoading = false;

  FavouriteProvider(){
    loadingFavList();
  }

  Future<void> loadingFavList()async{
    favList=await favouriteServices.getFavListFromLocal();
    notifyListeners();
  }

  Future<void> isFavouriteOrNot({String? productId})async {
    fav=await favouriteServices.isFavouriteOrNot(productId: productId);
    notifyListeners();
  }

    Future<void> addOrRemoveFavourite({String? userId,String? productId})async{
      try {
        isLoading=true;
        notifyListeners();

        await loadingFavList();
        if(!fav) favList!.add(productId!);
        else favList!.remove(productId);

        String type=!fav?"add":"remove";
        await favouriteServices.addOrRemoveFavourite(type:type,userId: userId,productId: productId,tempList: favList);

        isLoading=false;
        notifyListeners();
        Fluttertoast.showToast(msg:type+"ed successfully");

      }on FirebaseException catch (e) {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg:e.message!);
        print(e.message);

      }
  }


}
