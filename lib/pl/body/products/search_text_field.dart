import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provier/product_provider.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider=Provider.of<ProductProvider>(context);

    return  WillPopScope(
        onWillPop: ()async{
      productProvider.resetSearchAndCategory();
      return true;
    },
    child:Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(18)),
        child: TextField(
          onChanged: (value) {
            productProvider.setSearchedValue(value);
          },
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "   Search product ...",
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ),)

    );
  }
}
