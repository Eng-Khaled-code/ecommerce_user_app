import 'package:cloud_firestore/cloud_firestore.dart';
import '../pl/body/utilities/references/user_ref.dart';

class CartServices{

  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  UserRef userRef=UserRef();

 Future<bool>  checkItem({String? productId,String? userId})async{
   try
   {

     DocumentSnapshot data1=await firebaseFirestore.collection(userRef.collection).doc(userId).collection(userRef.cartList).doc(productId).get();

     if( data1.exists) return true;
     else return false;


   }
   catch(e)
   {
     return false;
   }

 }

  Future<void>  deleteItemFromCard({String? productId,String? userId})async{

      await firebaseFirestore.collection(userRef.collection).doc(userId).collection(userRef.cartList).doc(productId).delete();

  }


  Future<void>  deleteCartList({String? userId})async{

    await firebaseFirestore
        .collection(userRef.collection)
        .doc(userId)
        .collection(userRef.cartList)
        .get()
        .then((value){
              value.docs.forEach((element) async{
              await firebaseFirestore
                  .collection(userRef.collection)
                  .doc(userId)
                  .collection(userRef.cartList)
                  .doc(element.id)
                  .delete();
      });

    });

  }

  Future<void>  addItem({Map<String,dynamic>? data,String? userId})async{

    await firebaseFirestore
        .collection(userRef.collection)
        .doc(userId)
        .collection(userRef.cartList)
        .doc(data!["id"])
        .set(data);

  }

  Future<void>  updateItemToCard({Map<String,dynamic>? data,String? userId})async{

    await firebaseFirestore
        .collection(userRef.collection)
        .doc(userId)
        .collection(userRef.cartList)
        .doc(data!["id"])
        .update(data);

  }

  Future<double> loadingCartTotalPrice({String? userId})async{

    double total=0;
   await firebaseFirestore
       .collection(userRef.collection)
       .doc(userId)
       .collection(userRef.cartList)
       .get()
       .then((value){

          value.docs.forEach((element) {
            total+=element.get("total_price");
          });
    });


    return total;
  }

  Future<List<Map<String,dynamic>>> loadingCartItems({String? userId})async{

    List<Map<String,dynamic>> _cartItems=[];
    await firebaseFirestore
        .collection(userRef.collection)
        .doc(userId)
        .collection(userRef.cartList)
        .get()
        .then((value){

             value.docs.forEach((element) {
             _cartItems.add(element.data());
      });
    });

    return _cartItems;
  }

  Future<int> loadingCartTotalItemCount({String? userId})async{

    int total=0;
    await firebaseFirestore
        .collection(userRef.collection)
        .doc(userId)
        .collection(userRef.cartList)
        .get()
        .then((value){

            value.docs.forEach((element) {
              total+=element.get("item_count") as int;
      });
    });

    return total;
  }

  Future<int> loadingCartCounter({String? userId})async{

    int total=0;
   await firebaseFirestore
       .collection(userRef.collection)
       .doc(userId)
       .collection(userRef.cartList)
       .get()
       .then((value){
         total= value.docs.length;
    });

    return total;
  }
}