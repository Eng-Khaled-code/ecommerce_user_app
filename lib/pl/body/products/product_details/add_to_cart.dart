import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../model/product_model.dart';
import '../../../../provier/counters/cart_provider.dart';
import '../../utilities/references/cart_ref.dart';

// ignore: must_be_immutable
class AddToCartWidget extends StatelessWidget {
   AddToCartWidget({Key? key,this.productModel,this.cartProvider,this.userId}) : super(key: key);
   final CartProvider? cartProvider;
   final String? userId;
   final ProductModel? productModel;

   @override
  Widget build(BuildContext context) {
     checking();

    return
      cartProvider!.inCardOrNot==null
          ?
      loadingWidget()
          :
      IconButton(
        onPressed: () =>addToCart(),
        tooltip: cartProvider!.inCardOrNot!?"This product already in card":"Add to Cart",
        icon: Icon(
          Icons.shopping_cart,
          size: 30,
          color: cartProvider!.inCardOrNot!?Colors.pinkAccent:Colors.white,
        ),
      );

   }
    loadingWidget() {
     return Center(child: CircularProgressIndicator(color: Colors.white,));
   }

   Future<void> checking()async{
     await cartProvider!.checkItem(userId:userId,productId: productModel!.id);
   }


   addToCart() async {
     if(cartProvider!.inCardOrNot!)
       Fluttertoast.showToast(msg: "this item is already in cart");
     else{

       CartRef cartRef=CartRef() ;

       double _totalPrice=cartProvider!.cartNumOfItems * productModel!.price!;
       Map<String,dynamic>data={
         cartRef.id:productModel!.id,
         cartRef.name:productModel!.name,
         cartRef.itemCount:cartProvider!.cartNumOfItems,
         cartRef.price:_totalPrice,
         cartRef.imageURL:productModel!.imageURL,
         cartRef.shortInfo:productModel!.shortInfo!,
         cartRef.unitPrice:productModel!.price
       };

       await cartProvider!.addItemToCardList(data:data,userId: userId);

     }}

}
