import 'package:flutter/material.dart';
class CustomTextField extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final Function(String value)? onSave;
  final Function()? onTap;
  final String? initialValue;
  final TextInputType? textInputType;
   CustomTextField({
    @required this.label,
    @required this.icon,
    @required this.onSave,
     this.onTap,
     this.initialValue="",
     this.textInputType=TextInputType.text
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePass = true;

  IconData hidePassIcon = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: TextFormField( onSaved: (value) {
            widget.onSave!(value!);
          },
    initialValue:widget.initialValue,
    maxLines:widget.label=="more"||widget.label=="address"?3:1,
    keyboardType: widget.textInputType,
    obscureText: widget.label=="password"||
        widget.label=="new password"||widget.label=="old password"?hidePass:false,
    validator:(value){

      bool isNumeric(String s) {
        if (s == null) {
          return false;
        }
        return double.tryParse(s) != null;
      }

      bool phoneValidate = (value!.startsWith("011") ||
          value.startsWith("012") ||
          value.startsWith("010") ||
          value.startsWith("015")) &&
          isNumeric(value) &&
          value.length == 11;

    if(value.isEmpty&&widget.label!="phone 2 (not required)")
    {
    return "please enter ${widget.label!}";
    }
    else if(widget.label=="email")
    {

      Pattern pattern =
          r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$';

      RegExp regExp = RegExp(pattern.toString());
      if (!regExp.hasMatch(value)) return "email not valid";
    }
    else if(widget.label=="password"&&value.length<8)
    {
      return "password should be more than 8 characters";
    }

    else if((widget.label=="price")&&(isNumeric(value)==false||value=="0"||value=="0.0"))
    {
    return "enter valid value";

    }

    else if((widget.label=="quantity"||widget.label=="Flat/Home Number"||widget.label=="Pin code")&&(isNumeric(value)==false||value=="0"))
    {
      return "enter valid value";

    }
    else if((widget.label=="Phone Number"||widget.label=="phone 2 (not required)")&&!phoneValidate)
    {
      return "phone number not correct";
    }

    },
    decoration: InputDecoration(
                border:InputBorder.none,
                labelText: widget.label,
                icon: Icon(
                  widget.icon,
                ),
        suffixIcon:
    widget.label=="password"||widget.label=="new password"||widget.label=="old password"
    ?
    Padding(
    padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon:Icon(hidePassIcon),
              onPressed: ()=>onPressHideShow(),
            ),
          )
              :
          null,
            ),
            onTap: (){
            widget.onTap!();
            },
          ),
        ));
  }

  onPressHideShow() {
      setState(() {
        if (hidePass) {
          hidePass = false;
          hidePassIcon = Icons.visibility;
        } else {
          hidePass = true;
          hidePassIcon = Icons.visibility_off;
        }
      });

  }
}