import 'package:final_ecommerce/model/product_model.dart';
import 'package:final_ecommerce/provier/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../products/products_list.dart';
import '../utilities/text_style/text_styles.dart';
import 'custom_carousel.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    double height = MediaQuery.of(context).size.height;


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          carousel(height, productProvider.carasolList!),
          allProductTextWidget(),
          Divider(color: Colors.blue),
          ProductsListStreamBuilder()

        ],
      ),
    );
  }

  Align allProductTextWidget(){
    return Align(
        alignment: Alignment.center,
        child: Text("All Products",style: TextStyles.title,));
  }

  Widget carousel(double height, List<ProductModel> models,) {
    return models.length > 0
        ?
    CustomCarousel(height: height,models: models,)
        :
    loadingWidget(height);

  }

  loadingWidget(double height) {
    return Container(
      height: height * 0.35,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
