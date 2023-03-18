import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/pl/body/products/product_details/produc_details.dart';
import 'package:final_ecommerce/pl/body/products/product_card.dart';
import 'package:final_ecommerce/provier/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../utilities/widgets/notification_card.dart';
import '../screen_template.dart';
import '../utilities/constant/constants.dart';
import '../utilities/helper/helper.dart';
class ProductsListStreamBuilder extends StatelessWidget {
   ProductsListStreamBuilder({Key? key}) : super(key: key);

  String? screenSizeDesign;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider=Provider.of<ProductProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    screenSizeDesign=Helper().getDesignSize(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
          stream:searchStream(productProvider),
          builder: (context, snapshot) {

        return
                !snapshot.hasData
                ?
                Center(child: CircularProgressIndicator())
                              :
                snapshot.data!.size == 0 && productProvider.searchedValue == ""
                          ?
                NotificationCard(msg: "No items")
                              :
                snapshot.data!.size == 0 && productProvider.searchedValue != ""
                          ?
                NotificationCard(msg: "Retry Search")
                              :
                Container(
                height:height,
                child: GridView.builder(
                    gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio:2,
                        maxCrossAxisExtent: screenSizeDesign==AppConstants.smallDesign?width:width*.4
                    ),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, position) {
                      ProductModel product =ProductModel.fromSnapshoot(snapshot.data!.docs[position].data());
                      return   ProductCard(
                          productModel: product,

                      );
                    }),
              );
            }
          ),
    );
  }

Stream<QuerySnapshot<Map<String,dynamic>>> searchStream(ProductProvider productProvider){

    if (productProvider.searchedValue != "")
    {

        return
          productProvider.selectedCategory != "All"
                  ?
          (FirebaseFirestore.instance
            .collection("products")
            .where("category", isEqualTo: productProvider.selectedCategory)
            .where("product_name", isGreaterThanOrEqualTo: productProvider.searchedValue)
            .snapshots())
                  :
          (FirebaseFirestore.instance
            .collection("products")
            .where("product_name", isGreaterThanOrEqualTo: productProvider.searchedValue)
            .snapshots());
    }
    else
    {
        return  productProvider.selectedCategory != "All"
        ? (FirebaseFirestore.instance
            .collection("products")
            .where("category", isEqualTo: productProvider.selectedCategory)
            .snapshots())
            : (FirebaseFirestore.instance.collection("products").snapshots());
    }}

}
