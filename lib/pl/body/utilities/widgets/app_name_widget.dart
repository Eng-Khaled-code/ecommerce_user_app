import 'package:flutter/material.dart';
import '../../../../pl/body/utilities/constant/constants.dart';
import '../../../../pl/body/utilities/text_style/text_styles.dart';
class AppNameWidget extends StatelessWidget {
  const AppNameWidget({Key? key,this.text=AppConstants.appName}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text==""?AppConstants.appName:text!,
      style:TextStyles.appName,
    );
  }
}
