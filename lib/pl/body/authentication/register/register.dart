import 'dart:io';
import 'package:final_ecommerce/pl/body/authentication/register/profile_image_widget.dart';
import 'package:final_ecommerce/pl/body/authentication/register/sign_up.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../box_dialod/error_dialog.dart';
import '../../../../pl/body/utilities/constant/constants.dart';
import '../../../../pl/body/utilities/constant/insets.dart';
import '../../../../pl/body/utilities/constant/sizes.dart';
import '../../../../pl/body/utilities/constant/strings.dart';
import '../../../../pl/body/utilities/text_style/text_styles.dart';
import '../../../../pl/body/utilities/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {

  RegisterPage({key,this.formKey,this.userProvider}):super(key: key);

  GlobalKey<FormState>? formKey;
  UserProvider?  userProvider;

  String? txtUsername;

  String? txtPassword ;

  String? txtName ;

  File? imageFile;

  String? screenSizeDesign;

  @override
  Widget build(BuildContext context) {

    return
        WillPopScope(
          onWillPop: ()async{
            userProvider!.setSignUpPage(false);
            return false;
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Insets.logInHor, vertical:Insets.large),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                backToLogInButton(),

                title(),
                SizedBox(height:Sizes.sizedBoxLarge,),
                ProfileImageWidget(),
                SizedBox(height:Sizes.sizedBoxLarge,),
                buildNickNameTextFieldWidget(),
                SizedBox(height:Sizes.sizedBoxSmall,),
                buildEmailTextFieldWidget(),
                SizedBox(height:Sizes.sizedBoxSmall,),

                buildPasswordFieldWidget(),
                SizedBox(height:Sizes.sizedBoxLarge,),
                SignUpWidget(onPress: ()async=>await onRegisterButtonPressed(context),)
            ],
            ),
          ),
        );
  }

  onRegisterButtonPressed(BuildContext context) async {
    formKey!.currentState!.save();

    if (userProvider!.profileImage == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "you should choose a profile picture",
            );
          });
    }
    else if (formKey!.currentState!.validate())
    {
      await userProvider!.signInAndUpWithEmail(type: "sign up",username: txtName,email: txtUsername,password: txtPassword);
    }
  }
  CustomTextField buildNickNameTextFieldWidget() {
    return  CustomTextField(
      icon: Icons.person,
      onSave: (value)=>txtName=value,
      label: "Full name",
      initialValue: txtName,
      onTap: (){},
    );
  }

  CustomTextField buildEmailTextFieldWidget() {
    return  CustomTextField(
      icon: Icons.email,
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

  Widget title(){
    return  screenSizeDesign==AppConstants.largeDesign
        ?
    Container()
        :
    Text(Strings.signUp, style: TextStyles.logInLogo);
  }

  Align backToLogInButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: IconButton(icon:
        Icon(Icons.arrow_back,color: Colors.white,)
          ,onPressed: ()=> userProvider!.setSignUpPage(false)
        ,),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white)),
    ),);

  }
}
