
import 'package:final_ecommerce/pl/body/authentication/log_in/auth_icon.dart';
import 'package:final_ecommerce/pl/body/authentication/register/register.dart';
import 'package:final_ecommerce/pl/common_screens/loding_screen.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../pl/body/utilities/constant/constants.dart';
import '../../../pl/body/utilities/constant/insets.dart';
import '../../../pl/body/utilities/constant/sizes.dart';
import '../../../pl/body/utilities/constant/strings.dart';
import '../../../pl/body/utilities/text_style/text_styles.dart';
import '../../../pl/body/utilities/helper/helper.dart';
import '../../../pl/body/utilities/themes/app_colors/dark_colors.dart';
import '../../../pl/body/utilities/themes/app_colors/light_colors.dart';
import '../../../pl/body/utilities/themes/them_mode.dart';
import '../../../pl/body/authentication/log_in/log_in.dart';

class AuthenticationPage extends StatelessWidget {
   AuthenticationPage({key,this.themeMode}):super(key: key);
  final String? themeMode;

  final formKey = GlobalKey<FormState>();
  String? screenSizeDesign;


   @override
  Widget build(BuildContext context) {

    UserProvider  user = Provider.of<UserProvider>(context);
    screenSizeDesign=Helper().getDesignSize(context);

    return Scaffold(
        backgroundColor: themeMode==ThemeModeRef.lightMode?LightColors.startsBackground:DarkColors.startsBackground,
        body: user.status == Status.Authenticating
            ? LoadingScreen()
            : body(user: user,context: context));
  }


   Widget body({UserProvider? user,BuildContext? context}){
       return  Form(
           key: formKey,
           child: AnnotatedRegion<SystemUiOverlayStyle>(
             value: SystemUiOverlayStyle.light,
             child: GestureDetector(
               onTap: () => FocusScope.of(context!).unfocus(),
               child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                     leftColumnWidget(user!),
                      space() ,
                    vertDivider(),

                     mobileDesign(user)
                   ]
               ),
             ),
           ),

       );
     }

     Text title(UserProvider userProvider){
       return  Text(userProvider.signUpPage?Strings.signUp:Strings.logIn, style: TextStyles.logInLogo);
     }


   Expanded mobileDesign(UserProvider user) {
    return Expanded(
        child: user.signUpPage?RegisterPage(formKey: formKey,userProvider: user):LogIn(formKey: formKey,userProvider: user)
    );
  }

 Widget leftColumnWidget(UserProvider userProvider) {

     return screenSizeDesign==AppConstants.smallDesign?
     Container()
         : Expanded(
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: Insets.logInHor, vertical:Insets.logInVer+100),
             child: Column(children:
       [
         AuthIcon(
             size:screenSizeDesign==AppConstants.largeDesign
                 ?
             Sizes.registerIconForDesktop:Sizes.registerIconForMobile)
         , title(userProvider),]),
           ),
         );
  }

 Widget space() {
     return
       screenSizeDesign==AppConstants.smallDesign?
       Container()
           :
       SizedBox(width: 150,);

  }

  Widget vertDivider() {
     return  screenSizeDesign==AppConstants.smallDesign?
     Container()
         :
     VerticalDivider(color: Colors.white,width: 20,thickness: 1,);

  }



}