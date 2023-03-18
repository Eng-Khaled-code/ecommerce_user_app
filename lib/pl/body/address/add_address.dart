import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ecommerce/model/address_model.dart';
import 'package:final_ecommerce/provier/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provier/address_provider.dart';
import '../utilities/widgets/custom_text_field.dart';
import '../utilities/widgets/wide_button.dart';

class AddAddress extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
   String? nameController;
   String? phoneController;
   String? homNumberController ;
   String? cityController ;
   String? stateController ;
   String? pinCodeController;

  AddAddress({key,this.userId}):super(key: key);

   final String? userId;

  @override
  Widget build(BuildContext context) {
    AddressChange addressChange= Provider.of<AddressChange>(context);
    return addressChange.isLoading
        ?
        Center(child: CircularProgressIndicator(),)
        :
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        nameWidget(),
                        SizedBox(height: 15),
                        phoneNumberWidget(),
                        SizedBox(height: 15),
                        flatHomeNumberWidget(),
                        SizedBox(height: 15),
                        cityWidget(),
                        SizedBox(height: 15),
                        stateWidget(),
                        SizedBox(height: 15),
                        pinWidget(),
                      ],
                    )),
              ),
            ),
          ),
          WideButton(
              message: "Add Address",
              onPress: () async {
                formKey.currentState!.save();
                if (formKey.currentState!.validate()) {
                  Map<String,dynamic> data= AddressModel().toMap(
                      nameController,
                      phoneController,
                      homNumberController,
                      cityController,
                      stateController,
                      pinCodeController);
                     await addressChange.addAddress(data: data,userId: userId);
                      Navigator.pop(context);
                }
              },

          )
        ],
      ),
    );

}

  nameWidget() {
    return CustomTextField(
      icon: Icons.person,
      onSave: (value)=>nameController=value,
      label: "Full name",
      initialValue: nameController,
      onTap: (){},
    );
  }


  phoneNumberWidget() {
    return CustomTextField(
      icon: Icons.phone,
      onSave: (value)=>phoneController=value,
      label: "Phone Number",
      initialValue: phoneController,
      onTap: (){},
      textInputType: TextInputType.phone,

    );
  }

  flatHomeNumberWidget() {
    return CustomTextField(
      icon: Icons.home,
      onSave: (value)=>homNumberController=value,
      label: "Flat/Home Number",
      initialValue: homNumberController,
      onTap: (){},
      textInputType: TextInputType.number,

    );
  }


  cityWidget() {
    return CustomTextField(
      icon: Icons.location_city,
      onSave: (value)=>cityController=value,
      label: "City",
      initialValue: cityController,
      onTap: (){},
    );
  }


  pinWidget() {
    return CustomTextField(
      icon: Icons.pin,
      onSave: (value)=>pinCodeController=value,
      label: "Pin code",
      initialValue: pinCodeController,
      onTap: (){},
      textInputType: TextInputType.number,
    );
  }


  stateWidget() {
    return CustomTextField(
      icon: Icons.store_mall_directory,
      onSave: (value)=>stateController=value,
      label: "State",
      initialValue: stateController,
      onTap: (){},
    );
  }
}


