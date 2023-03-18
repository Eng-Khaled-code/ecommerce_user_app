import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/pl/body/utilities/references/address_ref.dart';
import 'package:final_ecommerce/pl/body/utilities/references/user_ref.dart';

class AddressServices{


  UserRef userRef=UserRef();
  AddressRef addressRef=AddressRef();
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  Future<void> addAddress({Map<String,dynamic>?data,String? userId})async {

    await firebaseFirestore
        .collection(userRef.collection)
        .doc(userId)
        .collection(addressRef.collection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(data!);

}

}