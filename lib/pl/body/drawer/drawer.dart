import 'package:final_ecommerce/pl/body/authentication/profile/my_account_page.dart';
import 'package:final_ecommerce/pl/body/favourate/fav_list.dart';
import 'package:final_ecommerce/pl/body/screen_template.dart';
import 'package:final_ecommerce/pl/body/orders/orders_page.dart';
import 'package:final_ecommerce/pl/body/products/searching_screen.dart';
import 'package:final_ecommerce/pl/body/shopping_cart/shopping_cart_page/shoping_cart.dart';
import 'package:flutter/material.dart';
import '../../../pl/body/help_page/help_page.dart';
import '../../../pl/body/setting/setting_page.dart';
import '../../../pl/body/drawer/drawer_header.dart';
import '../../../pl/body/drawer/drawer_tile.dart';
import '../home_page/home_page.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          CustomDrawerHeader(),
          CustomDrawerTile(icon:Icons.home, text: "Home", to:ScreenTemplate(HomePage(),"")),
          CustomDrawerTile(icon:Icons.person,text: "My Account", to: ScreenTemplate(MyAccount(),"Account Setting")),
          CustomDrawerTile(icon:Icons.shopping_basket, text: "My Orders", to: ScreenTemplate(OrdersPage(),"Orders")),
          CustomDrawerTile(icon:Icons.shopping_cart, text: "Shopping cart", to: ScreenTemplate(ShoppingCart(),"Shopping Cart")),
          CustomDrawerTile(icon:Icons.favorite,text: "Favourite", to:ScreenTemplate(FavouratePage(),"Favourite")),
          CustomDrawerTile(icon:Icons.search, text:"Search",to: ScreenTemplate(SearchingScreen(),"Searching...")),
          Divider(color: Colors.blueAccent,),
          CustomDrawerTile(icon:Icons.settings,text: "Setting",to :ScreenTemplate(SettingPage(),"Setting")),
          CustomDrawerTile(icon:Icons.help, text: "Help",to: ScreenTemplate(HelpPage(),"Help")),
          CustomDrawerTile(icon:Icons.arrow_back, text: "Log out", to: Container(),),
        ],
      ),
    );
  }
}
