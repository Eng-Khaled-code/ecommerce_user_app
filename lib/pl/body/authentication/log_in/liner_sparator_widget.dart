import 'package:flutter/material.dart';

import '../../utilities/text_style/text_styles.dart';

class LinearSeparatorWidget extends StatelessWidget {
  const LinearSeparatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        " Or sign in with ",
        style: TextStyles.title,
      ),
    );
  }
}
