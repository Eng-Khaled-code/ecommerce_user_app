import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../address/address_page/address.dart';
import '../../screen_template.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/widgets/wide_button.dart';
class BottomRow extends StatelessWidget {
  const BottomRow({Key? key,this.totalPrice,this.itemCount}) : super(key: key);
  final int? itemCount;
  final double? totalPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18)),
            boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1.0)]),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "Item Count \n\n $itemCount",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              "Total Price \n\n ${totalPrice!.toStringAsFixed(1)}\$",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 20.0),
            checkOutButton(context)
          ]

            ),

        );
}

  checkOutButton(BuildContext context) {
  return Expanded(
    child: WideButton(
      onPress: () async {

        if (itemCount==0) {
          Fluttertoast.showToast(msg: "your cart is empty");
        } else {
          Helper().goTo(context:context,to:ScreenTemplate(
              Address(
                totalPrice: totalPrice,
                totalItemCount: itemCount,
              ),"Select Address"
          ));
        }
      },
      message:
      "Check Out",
    ),
  );
  }
}
