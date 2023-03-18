import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key,this.userProvider}) : super(key: key);
  final UserProvider? userProvider;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        elevation: 10,
        shape: Border(
            bottom: BorderSide(color: Colors.white, width: 1.0),
            left: BorderSide(color: Colors.white, width: 1.0),
            right: BorderSide(color: Colors.white, width: 1.0),
            top: BorderSide(color: Colors.white, width: 1.0)),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: () async=> await userProvider!.googleSignIn(),
          child: Text(
            "Sign in with Google",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ));
  }
}
