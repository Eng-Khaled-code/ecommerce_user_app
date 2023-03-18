
import 'dart:io';

import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class ImageWidget extends StatefulWidget {
   ImageWidget({Key? key,this.userProvider,this.profPicture}) : super(key: key);
  final UserProvider? userProvider;
   File? profPicture;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            imageWidget(width,height),
            imageButtonWidget()
          ],
        ),
      ),
    );
  }

  Widget imageWidget(double width,double height) {
    return (widget.profPicture == null)
        ? (networkImageWidget(width,height))
        :  imageFileWidget(width,height);
  }

   ClipOval imageFileWidget(double width,double height) {
    return ClipOval(
      child: kIsWeb
          ?
      Image.network(
        widget.profPicture!.path,
        fit: BoxFit.cover,
        height: width*0.4,
        width: width * 0.4,
      )
          :
      Image.file(
        widget.profPicture!,
        height: width*0.4,
        width: width * 0.4,
        fit: BoxFit.cover,
      ),
      //downloading new image from our device
    );
   }

   Widget networkImageWidget(double width, double height) {
    return
      widget.userProvider!.userData!.photoURL != null
        ?
      ClipOval(
      child: FadeInImage.assetNetwork(
          image: widget.userProvider!.userData!.photoURL!,
          height: width * 0.4,
          width: width * 0.4,
          fit: BoxFit.cover,
          placeholder: "assets/images/glow.gif"),
    )
        :
      Icon(
      Icons.account_circle,
      color: Colors.grey,
      size: 90.0,
    );
  }

  IconButton imageButtonWidget() {
    return IconButton(
      icon: Icon(
        Icons.camera_alt,
        size: 100.0,
        color: Colors.white54.withOpacity(0.3),
      ),
      onPressed: getImageFromGallary,
      padding: EdgeInsets.all(0.0),
      splashColor: Colors.transparent,
      highlightColor: Colors.grey,
      iconSize: 200.0,
    );
  }

   Future getImageFromGallary() async {

     final pickedImage =
     await ImagePicker().pickImage(source: ImageSource.gallery);
     File newImageFile=File(pickedImage!.path);
     if (newImageFile != null) {
       setState(() {
         widget.profPicture = newImageFile;
       });
     }

   }
}
