import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/pl/body/products/product_details/produc_details.dart';
import 'package:final_ecommerce/pl/body/products/product_card.dart';
import 'package:final_ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provier/favourite_provider.dart';
import '../screen_template.dart';
import '../utilities/constant/constants.dart';
import '../utilities/helper/helper.dart';
import '../utilities/references/product_ref.dart';
import '../utilities/widgets/notification_card.dart';


class FavouratePage extends StatelessWidget {
  Stream<QuerySnapshot<Map<String ,dynamic>>>? stream;
  String? screenSizeDesign;

  initializeFavList(FavouriteProvider favouriteProvider) async{

    ProductRef productRef=ProductRef();
    await favouriteProvider.loadingFavList();
      stream = (
          favouriteProvider.favList.isEmpty
          ?
          FirebaseFirestore.instance
              .collection(productRef.collection)
              .where(productRef.productId, isNull: true)
              .snapshots()
          :
           FirebaseFirestore.instance
              .collection(productRef.collection)
              .where(productRef.productId, whereIn: favouriteProvider.favList)
              .snapshots());
    }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    screenSizeDesign=Helper().getDesignSize(context);
    FavouriteProvider favouriteProvider=Provider.of<FavouriteProvider>(context);

    initializeFavList(favouriteProvider);

    return stream==null
        ?
    Center(child: CircularProgressIndicator())
        :
    StreamBuilder<QuerySnapshot<Map<String ,dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          return
            !snapshot.hasData
              ?
            Center(child: CircularProgressIndicator())
              :
            snapshot.data!.size == 0
                  ?
            NotificationCard(msg: "No products in favourite",)
                  :
            GridView.builder(
              gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio:2,
                  maxCrossAxisExtent: screenSizeDesign==AppConstants.smallDesign?width:width*.4
              ),
              itemCount: snapshot.data!.size,
                      itemBuilder: (context, position) {
                        ProductModel product = ProductModel.fromSnapshoot(snapshot.data!.docs[position].data());
                        return InkWell(
                          onTap: () =>Helper().goTo(context: context,to:ScreenTemplate(
                                          ProductDetails(
                                              productModel: product),"Product Details")),
                          child: ProductCard(
                            productModel: product,
                          ),
                        );
                      }
                      );
        }
    );


  }
}
