
import 'package:final_ecommerce/provier/address_provider.dart';
import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:final_ecommerce/provier/favourite_provider.dart';
import 'package:final_ecommerce/provier/order_provider.dart';
import 'package:final_ecommerce/provier/product_provider.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:final_ecommerce/pl/body/start_point/screen_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pl/body/utilities/themes/app_thems/dark_them_data.dart';
import 'pl/body/utilities/themes/app_thems/light_them_data.dart';
import 'pl/body/utilities/themes/them_mode.dart';
import 'provier/theme_provider.dart';
import 'pl/body/start_point/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ThemeProvider()),
        ChangeNotifierProvider(create: (_)=>ProductProvider()),
        ChangeNotifierProvider(create: (_)=>AddressChange()),
        ChangeNotifierProvider(create: (_)=>CartProvider()),
        ChangeNotifierProvider(create: (_)=>FavouriteProvider()),
        ChangeNotifierProvider(create: (_)=>UserProvider.initialize()),
        ChangeNotifierProvider(create: (_)=>OrderProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, theme, _) =>MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode:theme.theme==ThemeModeRef.lightMode? ThemeMode.light:ThemeMode.dark,
      theme:lightThemeData(),
      darkTheme:darkThemeData(),
      home: theme.isLoading?Center(child: CircularProgressIndicator()):ScreenController(themeMode: theme.theme,),
    ));
  }
}
