import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
class DontHaveAccountButton extends StatelessWidget {
  const DontHaveAccountButton({Key? key,this.userProvider}) : super(key: key);
  final UserProvider? userProvider;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>userProvider!.setSignUpPage(true),
      child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Don\'t have an account? ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w100,
                    fontFamily: "signatra")),
            TextSpan(
                text: "  Sign up",
                style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))
          ])),
    );
  }
}
