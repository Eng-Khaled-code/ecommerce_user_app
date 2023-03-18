import 'package:final_ecommerce/pl/body/shopping_cart/cart_dialog/update_button.dart';
import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/constant/constants.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/widgets/custom_text_field.dart';
import '../../../box_dialod/cancel_button.dart';

class CartDialog extends StatelessWidget {
   CartDialog({Key? key,this.userId,this.price,this.productId,this.productName,this.quantity}) : super(key: key);
  final String? productId;
  final String? productName;
  final double? price;
  String? quantity;
  final String? userId;

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    CartProvider cart=Provider.of<CartProvider>(context);


    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: Text(productName!),
      content: content(context)
      ,actions: <Widget>[
      cart.loading
          ? loadingWidget()
          : UpdateButton(onPress: ()=>onPressUpdate(cart,context),),
      CancelButton(),
    ],
    );

  }

  content(BuildContext context) {
    bool isLargeDesignSize=Helper().getDesignSize(context)==AppConstants.largeDesign;
    return Container(
      height:100,
      width: isLargeDesignSize?MediaQuery.of(context).size.width*.5:double.infinity,

      child: Form(
        key: formKey,
        child:  Column(
          children: [
            quantityTextFieldWidget()
          ],
        ),
      ),
    );
  }

   CustomTextField quantityTextFieldWidget() {
     return  CustomTextField(
       icon: Icons.production_quantity_limits,
       label: "quantity",
       initialValue: quantity,
       onSave: (value2){
         quantity=value2;
       },
       onTap: (){},
     );
   }

   Container loadingWidget(){
     return Container(
         width: 17,
         height: 17,
         child: CircularProgressIndicator(
           strokeWidth: 0.7,
         ));
   }

   onPressUpdate(CartProvider cartProvider,BuildContext context) async{
     formKey.currentState!.save();
     if(formKey.currentState!.validate()){

       double unitPrice=price! / int.parse(quantity!);

       double _total=int.parse(quantity!)*unitPrice;

       Map<String,dynamic> data={"id":productId,    "item_count":int.parse(quantity!),    "total_price":_total};
       print("1111");
       await cartProvider.updateItemCart(userId: userId,data:data);
       print("ttt");

       Navigator.pop(context);

     }
   }
}
