import 'package:flutter/material.dart';
import '../../../../model/product_model.dart';
import '../../utilities/text_style/text_styles.dart';
class DetailsWidget extends StatelessWidget {
  const DetailsWidget({Key? key,this.productModel}) : super(key: key);
  final ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(children: [
            proImage(),
            Positioned(
                left: 0,
                bottom: height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Product: ${productModel!.name}",
                    style:TextStyles.title,

                  ),
                )),
            Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "${productModel!.price}\$",
                    style:TextStyles.title,

                  ),
                )),
            Positioned(
                left: 0,
                bottom: height * 0.025,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "Category: ${productModel!.category}\$",
                      ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Brand: ${productModel!.brand}",
                      ),
                ))
          ]),
    );
  }


  ClipRRect proImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0)),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/glow.gif",
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
        image: productModel!.imageURL!,
        imageErrorBuilder: (_, h, o) =>
            Image.asset("assets/images/errorimage.png"),
      ),
    );
  }

}
