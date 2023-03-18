import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:final_ecommerce/pl/body/utilities/helper/helper.dart';
import 'package:flutter/material.dart';

import '../../../model/product_model.dart';
import '../products/product_details/produc_details.dart';
import '../screen_template.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({Key? key,this.height,this.models}) : super(key: key);
  final double? height;
  final List<ProductModel>? models;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height! * 0.4,
        child: Carousel(
          onImageTap: (imageNum)=>onTap(imageNum,context),
          boxFit: BoxFit.cover,
          animationCurve: Curves.fastOutSlowIn,
          dotSize: 6.0,
          indicatorBgPadding: 8,
          autoplay: true,
          animationDuration: Duration(seconds: 3),
          images: [
            carasolImage(models![0].imageURL!),
            models!.length > 1
                ? carasolImage(models![1].imageURL!)
                : Container(
                child: Center(child: Text("No product loaded yet"))),
            models!.length > 2
                ? carasolImage(models![2].imageURL!)
                : Container(
                child: Center(child: Text("No product loaded yet"))),
            models!.length > 3
                ? carasolImage(models![3].imageURL!)
                : Container(
                child: Center(child: Text("No product loaded yet"))),
            models!.length > 4
                ? carasolImage(models![4].imageURL!)
                : Container(
                child: Center(child: Text("No product loaded yet"))),
          ],
        ));
  }

  Image carasolImage(String imageURL) {

    return Image.network(
      imageURL,
      fit: BoxFit.fill,
      errorBuilder:(_,i,u)=> Image.asset("assets/images/errorimage.png"),
    );
  }

  void onTap(int imageNum,BuildContext context) {
    imageNum < models!.length
        ? Helper().goTo(context:context,to: ScreenTemplate(ProductDetails(productModel: models![imageNum],),"ProductDetails"))
        : null;
  }
}
