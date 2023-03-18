import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../model/address_model.dart';
import '../../../../provier/order_provider.dart';
import '../../address/addrss_card/address_details.dart';
import '../../utilities/references/address_ref.dart';
import '../../utilities/references/user_ref.dart';
import '../../utilities/text_style/text_styles.dart';
import '../../utilities/widgets/wide_button.dart';

class ShippingDetails extends StatelessWidget {
  final String? orderId;
  final String? addressId;
  final String? status;
  final OrderProvider? orderProvider;
  final String? userId;
  ShippingDetails({Key? key,this.orderId,this.status,this.orderProvider,this.userId,this.addressId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
        future: myStream(),
        builder: (con, dataSnap) {
          return 
            !dataSnap.hasData 
                ?        
            Center(child: CircularProgressIndicator())
                :

          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                          SizedBox(height: 20),
                          title(),
                          Container(height: 300,child:AddressDetailsTable(addressModel: AddressModel.fromSnapshot(dataSnap.data!),)),
                          Divider(height: 2.0),
                          deliverButton()
                 ] ),
          );
        });


  }

  confirmUserOrderRecieve(String status) async{

    if(status=="not checked")
      Fluttertoast.showToast(msg:"admin don't see your order");
    else if(status=="sent")
      await orderProvider!.receivedOrder(orderId:orderId!);
    else if(status=="recived")

      Fluttertoast.showToast(msg:"you have received this order");

  }

  Padding title() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Text("Shipment Details",
        style: TextStyles.title,
      ),
    );
  }

 Padding deliverButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child:
          orderProvider!.loading
              ?
          CircularProgressIndicator()
              :
          status=="sent"
              ?
          WideButton(
              onPress: ()async=> await confirmUserOrderRecieve(status!),
              message: "Confirmed||order received")
              :
          Container(),));
 }

  myStream() {
    return FirebaseFirestore.instance
        .collection(UserRef().collection)
        .doc(userId)
        .collection(AddressRef().collection)
        .doc(addressId)
        .get();
  }
}