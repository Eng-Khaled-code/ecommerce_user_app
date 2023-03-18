import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pl/body/utilities/themes/them_mode.dart';

class ThemeProvider with ChangeNotifier {

  String theme=ThemeModeRef.lightMode;
  bool isLoading=true;

  ThemeProvider(){
    notifyListeners();
    SharedPreferences.getInstance().then((value)=>theme=value.getString(ThemeModeRef.mode)??ThemeModeRef.lightMode);
    isLoading=false;
    notifyListeners();
  }


  void setThemeMode(String mode) async {
    isLoading=true;
    notifyListeners();
    theme=mode;
    SharedPreferences.getInstance().then((value)=> value.setString(ThemeModeRef.mode, mode));
    isLoading=false;
    notifyListeners();
  }

}