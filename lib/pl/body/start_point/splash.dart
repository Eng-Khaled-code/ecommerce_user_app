import 'package:flutter/material.dart';

import '../../../pl/body/utilities/constant/sizes.dart';
import '../../../pl/body/utilities/themes/app_colors/dark_colors.dart';
import '../../../pl/body/utilities/themes/app_colors/light_colors.dart';
import '../../../pl/body/utilities/themes/them_mode.dart';
import '../../../pl/body/utilities/widgets/app_name_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({key,this.themeMode}):super(key: key);
  final String? themeMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode==ThemeModeRef.lightMode?LightColors.startsBackground:DarkColors.startsBackground,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon(),
              SizedBox(height: Sizes.sizedBoxSmall),
              AppNameWidget(),
              SizedBox(height: Sizes.sizedBoxLarge),
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        ),
    );
  }

  Icon icon()=>Icon(Icons.shopping_cart,size:Sizes.splashScreenIcon,color:Colors.white ,);


}
