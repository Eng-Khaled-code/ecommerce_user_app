import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../model/address_model.dart';
import '../../../../provier/address_provider.dart';
import '../../utilities/constant/constants.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/references/address_ref.dart';
import '../../utilities/references/user_ref.dart';
import '../../utilities/widgets/notification_card.dart';
import '../addrss_card/address_card.dart';

class AddressListWidget extends StatelessWidget {
   AddressListWidget({Key? key,this.totalPrice,this.totalItemCount,this.userId,this.addressChange}) : super(key: key);
  final double? totalPrice;
  final int? totalItemCount;
  final String? userId;
  final AddressChange? addressChange;
  String? screenSizeDesign;

  @override
  Widget build(BuildContext context) {
    screenSizeDesign=Helper().getDesignSize(context);
    double width = MediaQuery.of(context).size.width;

    return  StreamBuilder<QuerySnapshot>(
        stream: myStream(),
        builder: (context, snapshot) {
          return
            !snapshot.hasData||addressChange!.isLoading
                ?
            Center(child: CircularProgressIndicator(),)
                :
            snapshot.data!.size == 0
                ?
            NotificationCard(msg: "No shipment address has saved\nPlease add your shipment address \nso that we can deliver products",)
                : GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio:2,
                    maxCrossAxisExtent: screenSizeDesign==AppConstants.smallDesign?width:width*.5
                ),
                itemCount: snapshot.data!.size,
                itemBuilder: (context, position) {
                  AddressModel model=AddressModel.fromSnapshot(snapshot.data!.docs[position]);
                  return AddressCard(
                      addressChange: addressChange,
                      value: position,
                      totalAmount: totalPrice!,
                      totalItemCount:totalItemCount,
                      model:model);
                });

        });
  }

  Stream<QuerySnapshot> myStream(){
  return FirebaseFirestore.instance
        .collection(UserRef().collection)
        .doc(userId)
        .collection(AddressRef().collection)
        .snapshots();

  }

}
