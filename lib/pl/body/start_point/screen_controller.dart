
import 'package:final_ecommerce/pl/body/home_page/home_page.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication_page.dart';
import '../screen_template.dart';
import 'splash.dart';
class ScreenController extends StatelessWidget {
  const ScreenController({key,this.themeMode}):super(key: key);
  final String? themeMode;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch (user.status) {
      case Status.Uninitialized:
        return SplashScreen(themeMode: themeMode,);
      case Status.Authenticating:
      case Status.Unauthenticated:
      return AuthenticationPage(themeMode: themeMode,);
      case Status.Authenticated:
        return ScreenTemplate(HomePage(),"");
      default:
        return AuthenticationPage(themeMode: themeMode);
    }
  }

}
