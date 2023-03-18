import 'package:flutter/material.dart';
import '../../../../pl/body/utilities/constant/strings.dart';
import '../../../../pl/body/utilities/text_style/text_styles.dart';

class SignInButton extends StatelessWidget {
   SignInButton({Key? key,this.onPress}) : super(key: key);
   final Function? onPress;


@override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed:()=> onPress!(),
          child: Text(
            Strings.logIn,
            style:TextStyles.logInButtonText ,
          ),
        ));
    }

}
