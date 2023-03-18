import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../pl/body/utilities/constant/strings.dart';
class UpdateButton extends StatelessWidget {
  const UpdateButton({Key? key,this.onPress}) : super(key: key);
  final Function? onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          try {
            final result = await InternetAddress.lookup(
                'google.com');
            if (result.isNotEmpty &&
                result[0].rawAddress.isNotEmpty) {
              print("jjjj");
              onPress!();
              print("iiiiii");

            }
          } on SocketException catch (_) {
            Fluttertoast.showToast(
                msg: "you should connect to the internet",
                toastLength: Toast.LENGTH_LONG);
          }

        },
        child: Text(Strings.update));
  }
}
