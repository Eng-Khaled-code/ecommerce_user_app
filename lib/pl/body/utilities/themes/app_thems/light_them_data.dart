
import 'package:flutter/material.dart';

import '../../../../../pl/body/utilities/constant/sizes.dart';
import '../../../../../pl/body/utilities/themes/app_colors/light_colors.dart';
import '../../constant/fonts.dart';


ThemeData lightThemeData()=>ThemeData(
  brightness: Brightness.light,
    primaryColor:LightColors.primary ,
    scaffoldBackgroundColor: LightColors.background,
    backgroundColor: LightColors.background,
  fontFamily:Fonts.signatraFont ,
  accentColor: LightColors.accent,
    dividerColor: LightColors.divider,
     drawerTheme: DrawerThemeData(backgroundColor: LightColors.drawer,scrimColor: LightColors.drawer),
     elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),

);