import'package:flutter/material.dart';

import '../../../../provier/counters/cart_provider.dart';
import '../../utilities/text_style/text_styles.dart';

class QuantityRowWidget extends StatelessWidget {
   QuantityRowWidget({Key? key,this.cartProvider}) : super(key: key);
   final  CartProvider? cartProvider;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Container(
        decoration: BoxDecoration(
        //color: Colors.white,
        boxShadow: [
        BoxShadow(color: Colors.grey),
    BoxShadow(color: Colors.grey)
    ],
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(15.0),
    topLeft: Radius.circular(15.0))),
    height: height * 0.1,
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

        Text("Quantity : ",
          style:TextStyles.title,
        ),
        Padding(padding: const EdgeInsets.all(15.0), child:
        Text(cartProvider!.cartNumOfItems.toString().padLeft(2, "0"),
          style:TextStyles.title,

        ),),
        buttonsRow(width,height)
          ]),
    ));
  }

  buttonsRow(double width,double height) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: height * 0.04,
              width: width * 0.13,
              child: OutlinedButton(
                onPressed: () {
                  if (cartProvider!.cartNumOfItems > 1) cartProvider!.numOfItemIncrement(-1);

                },
                child: Icon(Icons.remove),
              )),
          SizedBox(width: 20.0),
          SizedBox(
              height: height * 0.04,
              width: width * 0.13,
              child: OutlinedButton(
                onPressed: ()=> cartProvider!.numOfItemIncrement(1),
                child: Icon(Icons.add),
              )),
          SizedBox(width: 10.0),

    ]);
  }
}
