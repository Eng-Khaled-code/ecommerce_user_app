
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../pl/body/utilities/constant/constants.dart';
class Helper{

 void goTo({BuildContext? context,Widget? to}){
  Navigator.push(
      context!,MaterialPageRoute(builder: (context) => to!));
}

String getDesignSize(BuildContext context){

  double screenWidth=MediaQuery.of(context).size.width;

  if(screenWidth<=700){
    return AppConstants.smallDesign;
  }
  return AppConstants.largeDesign;

}

}

