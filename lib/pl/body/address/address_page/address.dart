
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provier/address_provider.dart';
import '../../../../provier/user_provider.dart';
import '../../screen_template.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/widgets/wide_button.dart';
import '../add_address.dart';
import 'address_list_widget.dart';

class Address extends StatelessWidget {
  final double? totalPrice;
  final int? totalItemCount;
  Address({Key? key, this.totalPrice,this.totalItemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AddressChange addressChange = Provider.of<AddressChange>(context);
    final user = Provider.of<UserProvider>(context);

    return Column(
      children: [

        Expanded(child:
        AddressListWidget(totalItemCount: totalItemCount,totalPrice: totalPrice,addressChange: addressChange,userId: user.userData!.id,),),
       addAddressButton(context,user.userData!.id!)
      ],
    );
  }


  addAddressButton(BuildContext context,String userId){
    return WideButton(
        message: "Add Address",
        onPress: ()=>Helper().goTo(context:context, to: ScreenTemplate( AddAddress(userId: userId ,),"Add new Address")),
    );
  }

}
