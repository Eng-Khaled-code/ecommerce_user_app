import 'package:final_ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../shopping_cart/cart_dialog/cart_dialog.dart';

class CartQuantityButton extends StatelessWidget {
  const CartQuantityButton({Key? key,this.productModel,this.userId,this.quantity}) : super(key: key);
  final ProductModel? productModel;
  final String? quantity;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
      showDialog(context: context,
          builder: (context)=>CartDialog(
          productId: productModel!.id,
          quantity:quantity,
          price:productModel!.price,
          productName: productModel!.name,
              userId: userId
      ));
    },child:  Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      child: Text(
        "x"+quantity! ,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }
}
