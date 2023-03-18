import 'package:final_ecommerce/pl/body/products/searching_screen.dart';
import 'package:final_ecommerce/pl/body/utilities/constant/constants.dart';
import 'package:final_ecommerce/pl/body/utilities/helper/helper.dart';
import 'package:final_ecommerce/pl/body/utilities/widgets/app_name_widget.dart';
import 'package:final_ecommerce/pl/body/utilities/widgets/shoping_cart_button.dart';
import 'package:final_ecommerce/pl/body/drawer/drawer.dart';
import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../box_dialod/cancel_button.dart';
class ScreenTemplate extends StatelessWidget {
  ScreenTemplate(this.body,this.appBarTitle);
  final  Widget? body;
  final String? appBarTitle;
  final GlobalKey<ScaffoldState> scafoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    UserProvider user=Provider.of<UserProvider>(context);
    CartProvider cartProvider=Provider.of<CartProvider>(context);
   if (user.userData !=null){
     cartProvider.loadingCartCounter(userId:user.userData!.id!);}

        return WillPopScope(
        onWillPop:()async{
          bool con =appBarTitle==AppConstants.appName ? false:true;
        !con
            ?
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("خروج"),
              actions: [
                TextButton(onPressed: (){SystemNavigator.pop();}, child: Text("yes")),
                CancelButton(textColor: Colors.black,fontSize: 12,),],
              content: Text("هل تريد الخروج من التطبيق بالفعل"),
            ))
            :
            (){}
        ;
        return true;
          },
    child:Scaffold(
      key: scafoldKey,
        appBar: buildingMainAppBar(cartProvider,context),
        drawer: MyDrawer(),
        body: body,
        ));
  }


  AppBar buildingMainAppBar(CartProvider cartProvider,BuildContext context) {
    return AppBar(
      title: AppNameWidget(text: appBarTitle),
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
      actions: <Widget>[
        seachButton(context),
        ShoppingCartButton(),
      ],
    );
  }

  Widget seachButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search,color: Colors.white,),
        onPressed: ()=>Helper().goTo(to: ScreenTemplate(SearchingScreen(),"Searching..."),context: context));
  }

}
