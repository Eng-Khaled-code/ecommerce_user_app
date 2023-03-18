import 'package:final_ecommerce/model/product_model.dart';
import 'package:final_ecommerce/pl/body/products/product_details/produc_details.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provier/counters/cart_provider.dart';
import '../screen_template.dart';
import '../utilities/helper/helper.dart';
import '../utilities/text_style/text_styles.dart';
import 'cart/cart_quantity.dart';

class ProductCard extends StatelessWidget {
  final ProductModel? productModel;
  //has to values product and cart
  final String? type;
  late int? itemCount;
  ProductCard({Key? key, this.productModel,this.type="product",this.itemCount=1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   late UserProvider userProvider=Provider.of<UserProvider>(context);

  return InkWell(
    onTap: () {
        if(type=="product"){
        Helper().goTo(context:context,to:ScreenTemplate(
        ProductDetails(productModel:productModel),"ProductDetails"));
        }
        },
    child: Container(
        margin:const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            borderContainer(context,userProvider),
            cardImage(),
          ],
        ),
      ),
  );
  }

  BoxDecoration decoration() {
    return  BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.lightBlueAccent,

    );
  }

  Container borderContainer(BuildContext context,UserProvider userProvider) {
    return Container(
      height: 136,
      decoration:decoration(),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
             borderRadius: BorderRadius.circular(22),
             boxShadow: [BoxShadow(color: Colors.grey,blurRadius:.5)]
        ),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
          topLeftTextWidget(context),
          bottomRow(context,userProvider)
        ]) ,
      ),
    );
  }

  cardImage() {
    return Positioned(
        top: 30,
        right: 15.0,
        bottom: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.0),
          child: FadeInImage.assetNetwork(
            image: productModel!.imageURL!,
            fit: BoxFit.cover,
            width: 130.0,
            placeholder: 'assets/images/glow.gif',
          ),
        ));
  }

  topLeftTextWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              productModel!.name!,
              style:TextStyles.title
            ),
            Text(
              productModel!.shortInfo!,
              maxLines: 2,
            ),
            type=="product"? Text(
              "Brand : " + productModel!.brand!,
            ):Container(),
          ],
        ),
      ),
    );
  }

  bottomRow(BuildContext context,UserProvider userProvider) {
    return Row(
      children: [
        priceContainer(),
        type=="product"? favButton():Container(),
        type=="cart"?quantityWidget(userProvider,itemCount!):Container(),
        type=="cart"?deleteFromCartWidget(context,userProvider):Container(),

      ],
    );
  }

  favButton() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite,
            color: Colors.pinkAccent,
          ),
          SizedBox(width: 5.0),

          Text(productModel!.likeCounter.toString()
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)
      ),
    );
  }

  Container priceContainer() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      child: Text("${productModel!.price}\$"),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  IconButton deleteFromCartWidget(BuildContext context,UserProvider userProvider){
    return IconButton(icon:Icon(Icons.delete,color: Colors.black,size: 25.0,),
      onPressed: ()=> deleteFromCart(context,userProvider),
    );
  }

  deleteFromCart(BuildContext context,UserProvider userProvider) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(action: SnackBarAction(label:"Delete",
      onPressed: ()async{
        CartProvider _cartProvider=Provider.of<CartProvider>(context,listen: false);

        await _cartProvider.deleteItemFromCart(productId: productModel!.id,userId:userProvider.userData!.id);

      },),content:Text( "Do you want to delete "+productModel!.name!),));

  }

  quantityWidget(UserProvider userProvider,int itemCount) {
    return CartQuantityButton(productModel: productModel,userId: userProvider.userData!.id,quantity: itemCount.toString(),);
  }

}
