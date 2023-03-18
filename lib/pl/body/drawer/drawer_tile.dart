import 'package:final_ecommerce/provier/product_provider.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../pl/body/utilities/helper/helper.dart';
import '../../../pl/box_dialod/cancel_button.dart';
import '../../../provier/theme_provider.dart';
import '../utilities/constant/constants.dart';
import '../utilities/themes/them_mode.dart';
class CustomDrawerTile extends StatelessWidget {
  const CustomDrawerTile({Key? key,this.text,this.to,this.icon}) : super(key: key);
  final IconData? icon;
  final String? text;
  final Widget? to;


  @override
  Widget build(BuildContext context) {
     Color color= text=="Log out"?Colors.red:text=="Help"?Colors.greenAccent:Colors.blueAccent;
    return ListTile(
    title: Text(text!),
    leading: Icon(
    icon,
    color:color,
    ),
    onTap: ()=>text=="Log out"?onPressLogOut(context):text=="Night mode"?(){}
        :text==AppConstants.appName?goToHomeAndResetSerch(context):Helper().goTo(to: to,context: context),
      trailing: text=="Night mode"?switchMode():null,
    );
  }

Consumer switchMode(){

  return Consumer<ThemeProvider>(
      builder: (context, theme, _)=>
          Switch(
              value:theme.theme==ThemeModeRef.darkMode ,
              onChanged: (value){
                String newValue=value ?ThemeModeRef.darkMode:ThemeModeRef.lightMode;
                theme.setThemeMode(newValue);

              }));
}

  onPressLogOut(BuildContext context) {

    showDialog(context: context,
      builder: (context)
      => AlertDialog(

        title:Text("Log out"),content: Text("Do you want to log out"),
        actions: [
          TextButton(onPressed: ()async{
            Navigator.pop(context);
            Navigator.pop(context);
            await  Provider.of<UserProvider>(context,listen: false).signOut();
          }, child: Text("yes")),
          CancelButton(textColor: Colors.black,fontSize: 12,)
        ],

      )
      ,
      barrierDismissible: true,

    );
  }

  goToHomeAndResetSerch(BuildContext context) {

    Provider.of<ProductProvider>(context,listen: false).resetSearchAndCategory();
    Helper().goTo(to: to,context: context);
  }
}
