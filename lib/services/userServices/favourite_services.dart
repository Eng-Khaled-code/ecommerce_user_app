import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/pl/body/utilities/references/user_ref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pl/body/utilities/references/product_ref.dart';

class FavouriteServices
{
  SharedPreferences? preferences;
  UserRef userRef=UserRef();
  ProductRef productRef=ProductRef();
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  Future<void> setFavListToLocal(List<String> favList) async{
    //this method called on onStatusChange method on starting this App
    preferences=await SharedPreferences.getInstance();
    await preferences!.setStringList(userRef.favList,favList);
  }

  Future<List<String>> getFavListFromLocal()async{
    preferences=await SharedPreferences.getInstance();
    return preferences!.getStringList("favList")!;
  }

  Future<bool> isFavouriteOrNot({String? productId})async{
    preferences=await SharedPreferences.getInstance();
    return preferences!.getStringList(userRef.favList)!.contains(productId);
  }

  addOrRemoveFavourite({String? type,String? userId,String? productId,List<String>? tempList})async{

  await firebaseFirestore
      .collection(userRef.collection)
      .doc(userId)
      .update({
       userRef.favList: tempList,
       });

  await setFavListToLocal(tempList!);

  int incrementValue=type=="add"?1:-1;

  await firebaseFirestore.collection(productRef.collection).doc(productId).update({productRef.likeCounter:FieldValue.increment(incrementValue)});


  }

}