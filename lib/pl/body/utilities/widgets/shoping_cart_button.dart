import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shopping_cart/shopping_cart_page/shoping_cart.dart';
import '../../../../pl/body/utilities/text_style/text_styles.dart';
import '../../../../pl/body/utilities/helper/helper.dart';
import '../../screen_template.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      button(context),
      cartItemsCount(),
    ]);
  }

  button (BuildContext context) {
    return Center(
      child: IconButton(
          icon: Icon(Icons.shopping_cart,color: Colors.white),
          onPressed: ()=>Helper().goTo(to:ScreenTemplate(ShoppingCart(),"Shopping cart"),context:context)),
    );

 }

  cartItemsCount() {
    return Positioned(
        left: 0,
        top: 0,
        child: Stack(
        children: [
                  Icon(
                  Icons.brightness_1,
                  size: 25,
                  color: Colors.yellowAccent,
              ),
              Positioned(
                  top: 5.0,
                  bottom: 4.0,
                  left: 8.0,
                  child:
                  Consumer<CartProvider>(
                      builder: (context, cartProvider, _) =>
                    Text(cartProvider.cardCounter.toString(), style: TextStyles.cartCount,),))
        ])

    );
  }
}
