import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../provier/user_provider.dart';
class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({key}):super (key:key);

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider=Provider.of<UserProvider>(context);

    return InkWell(
      onTap:()=> selectAndPickImage(userProvider),
      child: ClipOval(
    child:Container(
        color: Colors.white,
        width: 200,height: 200,child:
    userProvider.profileImage==null
    ?
    addPhotoIcon(context)
        :
    kIsWeb
    ?
    Image.network(userProvider.profileImage!.path,fit: BoxFit.cover,)
        :
    Image.file(userProvider.profileImage!,fit: BoxFit.cover)
    )));
  }

  addPhotoIcon(BuildContext context)
  {
    return Icon(
      Icons.add_photo_alternate,
      size: MediaQuery.of(context).size.width * 0.1,
    );
  }


  Future<void> selectAndPickImage(UserProvider userProvider) async {
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    userProvider.setProfileImage(File(image!.path));
  }

}
