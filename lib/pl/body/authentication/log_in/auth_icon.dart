import 'package:flutter/material.dart';

class AuthIcon extends StatelessWidget {
  const AuthIcon({Key? key,this.size}) : super(key: key);
  final double? size;
  @override
  Widget build(BuildContext context) {
    return  Icon(Icons.shopping_cart,size:size!,
      color:Colors.white ,);
  }
}
