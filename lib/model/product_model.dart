import 'package:cloud_firestore/cloud_firestore.dart';

import '../pl/body/utilities/references/product_ref.dart';

class ProductModel
{

  String? id;
  String? category;
  String? name;
  String? brand;
  String? imageURL;
  int? quantity;
  double? price;
  String? desc;
  Timestamp? publishDate;
  String? shortInfo;
  String? status;
  int? likeCounter;


  ProductModel(this.id,this.price,this.name,this.imageURL,this.shortInfo);

  ProductModel.fromSnapshoot(Map<String,dynamic> productData )
  {

    ProductRef productRef=ProductRef();
    id = productData[productRef.productId];
    category = productData[productRef.category];
    name = productData[productRef.productName];
    brand = productData[productRef.brand];
    price = productData[productRef.price];
    quantity = productData[productRef.quantity];
    imageURL=productData[productRef.imageUrl];
    desc=productData[productRef.description];
    publishDate=productData[productRef.publishDate];
    shortInfo=productData[productRef.shortInfo];
    status=productData[productRef.status];
    likeCounter=productData[productRef.likeCounter]??0;

  }


}