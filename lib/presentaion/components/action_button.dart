import 'package:flutter/material.dart';
class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, required this.buttonText , required this.press}) : super(key: key);
final VoidCallback press;
final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: const Size(300, 60)),
        child:  Text(
         buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ));
  }
}
