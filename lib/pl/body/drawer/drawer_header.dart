import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provier/user_provider.dart';
class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return
      userProvider.userData!.id==null
        ?
    Center(child: CircularProgressIndicator(),)
        :
    UserAccountsDrawerHeader(
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          backgroundImage: NetworkImage(userProvider.userData!.photoURL!),
          backgroundColor: Colors.grey,
        ),
      ),
      accountEmail: Text( userProvider.userData!.email!,
        style: TextStyle(color: Colors.white),
      ),
      accountName: Text( userProvider.userData!.name!,
          style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
