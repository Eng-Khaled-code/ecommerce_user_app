import 'package:flutter/material.dart';

import '../../pl/body/utilities/constant/sizes.dart';
import '../../pl/body/utilities/text_style/text_styles.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)),
            SizedBox(height: Sizes.sizedBoxSmall),
            Text(
              "Loading...",

            )
          ],
        ),
      ),
    );

  }
}
