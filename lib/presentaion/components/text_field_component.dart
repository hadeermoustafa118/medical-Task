import 'package:flutter/material.dart';
class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({Key? key, required this.textInputType , required this.hintText,required this.tap, this.enable= true,required this.controller}) : super(key: key);
final TextInputType textInputType;
final String hintText;
final VoidCallback tap;
final bool enable;
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enable,
      onTap: tap ,
      keyboardType: textInputType,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
