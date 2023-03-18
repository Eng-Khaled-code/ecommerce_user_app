import 'package:flutter/material.dart';

import '../../utilities/text_style/text_styles.dart';
class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child:TextButton(
        child: Text(
          "Forget password?",
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );;
  }
}
