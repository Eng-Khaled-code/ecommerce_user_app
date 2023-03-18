
import 'package:final_ecommerce/pl/body/authentication/log_in/sign_in.dart';
import 'package:flutter/material.dart';
import '../../../../provier/user_provider.dart';
import '../../utilities/constant/constants.dart';
import '../../utilities/constant/insets.dart';
import '../../utilities/constant/sizes.dart';
import '../../utilities/constant/strings.dart';
import '../../utilities/helper/helper.dart';
import '../../utilities/text_style/text_styles.dart';
import '../../utilities/widgets/custom_text_field.dart';
import 'auth_icon.dart';
import 'dont_have_account_button.dart';
import 'forget_password_widget.dart';
import 'google_sign_in.dart';
import 'liner_sparator_widget.dart';

class LogIn extends StatelessWidget {
   LogIn({Key? key,this.formKey,this.userProvider}) : super(key: key);
  String? txtUsername ;
  String? txtPassword ;
   String? screenSizeDesign;
  GlobalKey<FormState>? formKey;
  UserProvider?  userProvider;
   @override
  Widget build(BuildContext context) {
    screenSizeDesign=Helper().getDesignSize(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Insets.logInHor, vertical:Insets.logInVer),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon(),
          title(),
          SizedBox(height:Sizes.sizedBoxLarge,),
          buildEmailTextFieldWidget(),
          SizedBox(height:Sizes.sizedBoxSmall,),
          buildPasswordFieldWidget(),
          SizedBox(height:Sizes.sizedBoxSmall,),
          ForgetPasswordWidget(),
          SizedBox(height:Sizes.sizedBoxSmall,),
          SignInButton(onPress:()async=>await onPressLogInButton(),),
          SizedBox(height:Sizes.sizedBoxSmall,),
          LinearSeparatorWidget(),
          SizedBox(height:Sizes.sizedBoxSmall,),
          GoogleSignInButton(userProvider: userProvider,),
          SizedBox(height:Sizes.sizedBoxSmall,),
          DontHaveAccountButton(userProvider: userProvider)
        ],
      ),);
  }

   onPressLogInButton() async {
     print("object");
     formKey!.currentState!.save();
     if (formKey!.currentState!.validate())
       await userProvider!.signInAndUpWithEmail(type:"sign in",email: txtUsername,password: txtPassword);
     print("object2");

   }
   Widget title(){

     return Text(Strings.logIn, style: TextStyles.logInLogo);
   }

  CustomTextField buildEmailTextFieldWidget() {
    return  CustomTextField(
      icon: Icons.person,
      onSave: (value)=>txtUsername=value,
      label: "email",
      initialValue: txtUsername,
      textInputType: TextInputType.emailAddress,
      onTap: (){},
    );
  }

  CustomTextField buildPasswordFieldWidget(){
    return CustomTextField(
      label: "password",
      icon: Icons.lock,
      onSave: (value)=>txtPassword=value,
      initialValue: txtPassword,
      textInputType: TextInputType.emailAddress,
      onTap: (){},
    );
  }

  Widget icon() {
     return
       screenSizeDesign==AppConstants.largeDesign
           ?
       Container()
           :
       AuthIcon( size:screenSizeDesign==AppConstants.largeDesign
           ?
       Sizes.registerIconForDesktop:Sizes.registerIconForMobile);
  }


}
