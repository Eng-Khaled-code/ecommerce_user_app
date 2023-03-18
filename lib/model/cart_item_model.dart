
import '../pl/body/utilities/references/cart_ref.dart';

class CartItemModel {


  String? id;
  String? name;
  int? itemCount;
  double? price;
  String? imageURL;
  String? shortInfo;
  double? unitPrice;
  CartItemModel({this.name,this.itemCount,this.price,this.id,this.imageURL,this.shortInfo,this.unitPrice});

  CartItemModel.fromSnapshot(Map<String,dynamic> data){
    CartRef cartRef=CartRef();
    id=data[cartRef.id];
    name=data[cartRef.name];
    itemCount=data[cartRef.itemCount];
    price=data[cartRef.price];
    imageURL=data[cartRef.imageURL];
    shortInfo=data[cartRef.shortInfo];
    unitPrice=data[cartRef.unitPrice];

  }


}
