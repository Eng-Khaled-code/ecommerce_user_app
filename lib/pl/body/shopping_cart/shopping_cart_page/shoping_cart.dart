import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/product_model.dart';
import 'package:final_ecommerce/model/cart_item_model.dart';
import 'package:final_ecommerce/pl/body/utilities/references/user_ref.dart';
import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../products/product_card.dart';
import '../../utilities/constant/constants.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/widgets/notification_card.dart';
import 'bottom_row.dart';

class ShoppingCart extends StatelessWidget {

  double totalPrice = 0.0;
  int itemCount = 0;
  String? screenSizeDesign;

  initialize(String userId,CartProvider cartProvider)async{
    cartProvider.loadTotalItemCount(userId: userId);
    cartProvider.loadTotalPrice(userId: userId);

    totalPrice=cartProvider.totalPrice;
    itemCount=cartProvider.totalItemCounter;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user=Provider.of<UserProvider>(context);
    CartProvider cartProvider=Provider.of<CartProvider>(context);
    double width = MediaQuery.of(context).size.width;
    screenSizeDesign=Helper().getDesignSize(context);

    initialize(user.userData!.id!,cartProvider);

    return Column(
      children: [
        Expanded(
          child:listWidget(user.userData!.id,width,cartProvider),
        ),
        BottomRow(totalPrice: totalPrice,itemCount: itemCount)
      ],
    );
  }


  Stream<QuerySnapshot<Map<String,dynamic>>> myStream(String userId){
   UserRef userRef= UserRef();
    return FirebaseFirestore.instance.collection(userRef.collection).doc(userId).collection(userRef.cartList).get().asStream();

  }

  listWidget(String? userId, double width,CartProvider cartProvider) {
    return  Container(
      child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
          stream: myStream(userId!),
          builder: (context, snapshot) {
            return  !snapshot.hasData||cartProvider.loading
                ?
            Center(child: CircularProgressIndicator(),)
                :
            snapshot.data!.size == 0
                ?
            NotificationCard(msg: "Cart is empty \n start adding items to cart")
                :
            GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio:2,
                    maxCrossAxisExtent: screenSizeDesign==AppConstants.smallDesign?width:width*.4
                ),
                itemCount: snapshot.data!.size,
                itemBuilder: (context, position) {
                  CartItemModel _cartModel=CartItemModel.fromSnapshot(snapshot.data!.docs[position].data());
                  ProductModel productModel=ProductModel(_cartModel.id, _cartModel.price, _cartModel.name, _cartModel.imageURL, _cartModel.shortInfo);
                  return ProductCard(
                      productModel:productModel,type: "cart",itemCount: _cartModel.itemCount,
                  );
                });
          }),
    );
  }
}
