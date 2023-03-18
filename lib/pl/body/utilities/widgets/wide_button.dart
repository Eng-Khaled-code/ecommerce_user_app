import 'package:flutter/material.dart';

import '../text_style/text_styles.dart';

class WideButton extends StatelessWidget {
  final String? message;
  final Function()? onPress;

  WideButton({Key? key, this.message, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: InkWell(
          highlightColor: Colors.white,
          hoverColor:Colors.white ,
          onTap: onPress,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
            color: Colors.blue
            ),
            width: MediaQuery.of(context).size.width*0.85,
            height: 50,
            child: Center(child: Text(message!,style:TextStyles.title),),
          ),
        ),
      ),
    );
  }
}
