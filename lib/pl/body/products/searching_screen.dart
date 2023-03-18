
import 'package:final_ecommerce/pl/body/products/products_list.dart';
import 'package:final_ecommerce/pl/body/products/search_text_field.dart';
import 'package:flutter/material.dart';
import 'categories_list_widget.dart';

class SearchingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Theme.of(context).backgroundColor==Colors.white?Colors.blue:Theme.of(context).backgroundColor,
        child: Column(
          children: [
            CustomSearchTextField(),
            CategoriesListWidget(),
            SizedBox(height: 20),
            products()],
        ),

    );
  }

 Expanded products(){
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)),
                color: Colors.white),
          ),
          ProductsListStreamBuilder(),

        ],
      ),
    );
  }
}
