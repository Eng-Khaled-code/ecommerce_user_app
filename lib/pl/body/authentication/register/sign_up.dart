
import 'package:flutter/material.dart';
import '../../../../pl/body/utilities/constant/strings.dart';
import '../../../../pl/body/utilities/text_style/text_styles.dart';
class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key,this.onPress}) : super(key: key);
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(25),
          child: MaterialButton(
            onPressed:()=> onPress!(),
            child: Text(
              Strings.signUp,
              style: TextStyles.title.copyWith(color: Colors.blue),
            ),
            minWidth: double.infinity,
          )),
    );
  }


}
