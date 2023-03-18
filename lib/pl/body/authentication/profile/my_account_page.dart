import 'dart:io';
import 'package:final_ecommerce/pl/body/authentication/profile/image_widget.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/text_style/text_styles.dart';
import '../../utilities/widgets/custom_text_field.dart';
import '../../utilities/widgets/wide_button.dart';

class MyAccount extends StatelessWidget {

  String? nicknameTextEditingController;
  final FocusNode nicknameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =Provider.of<UserProvider>(context);
    double width = MediaQuery.of(context).size.width;
    nicknameTextEditingController=userProvider.userData!.name;
    return  Form(
          key: _formKey,
          child: userProvider.isLoading
              ?
          Center(child:CircularProgressIndicator())
              :
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageWidget(userProvider: userProvider),
                Text("Email : ${userProvider.userData!.email}",style:TextStyles.title),
                SizedBox(height: 10),
                nickNameField(width),
                SizedBox(height: 15),
                WideButton(
                  message: "update",
                  onPress:  ()=>updateData(userProvider),
                )


              ],
            ),
          )
    );
  }


  updateData(UserProvider userProvider) async {
    _formKey.currentState!.save();
    if(_formKey.currentState!.validate()) {
      nicknameFocusNode.unfocus();
      await userProvider.updateUserData(
          nickName: nicknameTextEditingController, profileImage: profileImage);
    }
  }

  Padding nickNameField(double width){

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.075),
        child: CustomTextField(
          icon: Icons.store_mall_directory,
          onSave: (value)=>nicknameTextEditingController=value,
          label: "Nick Name",
          initialValue: nicknameTextEditingController,
          onTap: (){},
        ),
      );

  }
}
