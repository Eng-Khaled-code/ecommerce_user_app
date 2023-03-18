import 'package:final_ecommerce/model/product_model.dart';
import 'package:final_ecommerce/pl/body/products/product_details/quantity_row_widget.dart';
import 'package:final_ecommerce/provier/counters/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provier/user_provider.dart';
import '../../utilities/text_style/text_styles.dart';
import 'add_to_cart.dart';
import 'add_to_favourite.dart';
import 'details_widget.dart';


class ProductDetails extends StatelessWidget {
  final ProductModel? productModel;

  ProductDetails({Key? key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    CartProvider cartProvider = Provider.of<CartProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: ()async{
        cartProvider.resetNumOfItems();
        return true;
      },
      child: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  user.userData != null?expandedAppBar(height, cartProvider, user.userData!.id!):Container(),
                  sliverListDescWidget()
                ],
              ),
            ),
            QuantityRowWidget(cartProvider: cartProvider,)
          ],
        ),
      ),
    );
  }


  SliverAppBar expandedAppBar(double height, CartProvider cartProvider, String userId) {
    return SliverAppBar(

        expandedHeight: height * 0.6,
        pinned: true,
        floating: true,
        leading: AddToCartWidget(productModel: productModel,
          cartProvider: cartProvider, userId: userId,),
        actions: [AddToFavouriteWidget(userId: userId, productId: productModel!.id,)],
        flexibleSpace: FlexibleSpaceBar(
            background: DetailsWidget(productModel: productModel,))
    );
  }

  sliverListDescWidget() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: buildDescriptionWidgets(context));
          }
        }, childCount: 3));
  }

  Widget buildDescriptionWidgets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style:TextStyles.title,
        ),
        Text(
          productModel!.desc!,
          style: TextStyle(height: 1.5, fontSize: 15),
        ),
      ],
    );
  }

}