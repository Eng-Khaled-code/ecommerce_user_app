import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'order_card/order_card.dart';
import '../utilities/constant/constants.dart';
import '../utilities/helper/helper.dart';
import '../utilities/references/order_ref.dart';
import '../utilities/widgets/notification_card.dart';

class OrdersPage extends StatelessWidget {
  String? screenSizeDesign;
  OrderRef orderRef=OrderRef();


  @override
  Widget build(BuildContext context) {

    screenSizeDesign=Helper().getDesignSize(context);
    double width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context);

    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: myStream(user.userData!.id!),
        builder: (context, snapshot) {
          return
            !snapshot.hasData
              ?
          Center(child: CircularProgressIndicator())
              :
          snapshot.data!.size == 0
                  ?
          NotificationCard(msg:"Orders List Empty\n start adding orders" )
                  :
          GridView.builder(
              gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: screenSizeDesign==AppConstants.smallDesign?width:width*0.41
                     ),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, position) {
               return OrderCard(
                 itemCount: snapshot.data!.docs[position].get(orderRef.cartList).length,
                orderData: snapshot.data!.docs[position].get(orderRef.cartList),
                orderId: snapshot.data!.docs[position].id,
                navigate: true,
                orderTotalPrice: snapshot.data!.docs[position].get(orderRef.totalAmount),
                );
                      });
        });
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> myStream(String userId){
    return FirebaseFirestore.instance
        .collection(orderRef.collection).where(orderRef.orderBy,isEqualTo: userId)
        .snapshots();
  }

}
