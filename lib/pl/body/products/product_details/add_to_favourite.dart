import 'package:final_ecommerce/provier/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToFavouriteWidget extends StatelessWidget {
   AddToFavouriteWidget({Key? key,this.userId,this.productId}) : super(key: key);
  final String? userId;
  final String? productId;

  SharedPreferences? preferences ;
  @override
  Widget build(BuildContext context) {

    FavouriteProvider favouriteProvider=Provider.of<FavouriteProvider>(context);
    favouriteProvider.isFavouriteOrNot(productId: productId);

    return
      favouriteProvider.isLoading==true
        ?
    loadingWidget()
          :
      IconButton(
      onPressed: () => favouriteProvider.addOrRemoveFavourite(userId: userId,productId: productId),
        tooltip:favouriteProvider.fav?"Remove from favourite": "Add to Favourite",
      icon: Icon(
        favouriteProvider.fav?Icons.favorite:Icons.favorite_border,
        size: 30,
        color:  favouriteProvider.fav?Colors.pinkAccent:Colors.white,
      ),
    );
  }

   loadingWidget() {
    return Center(child: CircularProgressIndicator(color: Colors.white,));
  }



}
