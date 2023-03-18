import 'package:flutter/material.dart';

import '../../../../model/address_model.dart';
import '../../../../provier/address_provider.dart';
import '../../utilities/widgets/wide_button.dart';
import '../../orders/payment_page.dart';
import '../../screen_template.dart';
import '../../utilities/helper/helper.dart';
import 'address_details.dart';

class AddressCard extends StatelessWidget {
  final AddressModel? model;
  final double? totalAmount;
  final int? value;
  final int? totalItemCount;
  final AddressChange? addressChange;
  AddressCard(
      {Key? key,
        this.addressChange,
        this.model,
        this.totalAmount,
        this.value,this.totalItemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> addressChange!.setIndex(value!),
      child: Card(
        color: Theme.of(context).backgroundColor==Colors.white?Colors.blue:Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            radio(),
            AddressDetailsTable(addressModel: model,),
            proceedButton(context)

          ],
        ),
      ),
    );
  }

 Widget proceedButton(BuildContext context) {
  return
    value == addressChange!.currentIndex
      ?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: WideButton(
      message: "Proceed",
      onPress: ()=>Helper().goTo(context:context,to: ScreenTemplate(PaymentPage(
                  addressId: model!.id!,
                  totalAmount: totalAmount!,
                  totalItemCount: totalItemCount,
                ),"Payment"))),
    )
        :
    Container();


  }

 Row radio() {
    return Row(
      children: [
        Radio<int>(
            value: value!,
            groupValue: addressChange!.currentIndex,
            activeColor: Colors.white,
            onChanged: (int? value) {
              addressChange!.setIndex(value!);
            }),
      ],
    );
 }
}


