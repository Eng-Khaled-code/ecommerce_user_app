import 'package:final_ecommerce/pl/body/orders/orders_page.dart';
import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:final_ecommerce/provier/order_provider.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen_template.dart';
import '../utilities/helper/helper.dart';
import '../utilities/references/order_ref.dart';
import '../utilities/widgets/wide_button.dart';

class PaymentPage extends StatelessWidget {
  final String? addressId;
  final double? totalAmount;
  final int? totalItemCount;
  PaymentPage({Key? key, this.addressId, this.totalAmount,this.totalItemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.loadingCartItems(userId:user.userData!.id!);
    final orderProvider = Provider.of<OrderProvider>(context);


  return Center(
      child: cartProvider.loading
          ||
          cartProvider.cartItems==null
          ?
      CircularProgressIndicator()
          :
      Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      moneyIcon(),
      SizedBox(height: 10.0),
      WideButton(
        onPress:()async=>await addOrder(context,user,orderProvider,cartProvider.cartItems!),
        message: "Place Order",),
    ],
  ));
  }

  addOrder(BuildContext context,UserProvider user,OrderProvider orderProvider,List<Map<String,dynamic>> cartItems) async {
    OrderRef orderRef=OrderRef();

    Map<String,dynamic>data={
        orderRef.addressId: addressId,
    orderRef.totalAmount: totalAmount,
      orderRef.totalItemCount:totalItemCount,
      orderRef.orderBy: user.userData!.id,
      orderRef.cartList: cartItems,
      orderRef.paymentType: "cash on Delivery",
      orderRef.orderTime: DateTime.now().millisecondsSinceEpoch.toString(),
      orderRef.isSuccess: "not checked"
  };

    if(await orderProvider.addOrder(data: data))
    {
      Navigator.pop(context);
      Navigator.pop(context);
      Helper().goTo(context: context, to: ScreenTemplate(OrdersPage(),"Orders"));

    }

  }


 Padding moneyIcon() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.monetization_on,
        size: 100,
        color: Colors.blue,
      ),
    );
  }

}
