import 'package:flutter/material.dart';
class VisitBookButton extends StatelessWidget {
  const VisitBookButton({Key? key, required this.buttonText , required this.press}) : super(key: key);
  final VoidCallback press;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: Colors.black,
            fixedSize: const Size(350, 60)),
        child:  Text(
          buttonText,
          style: const TextStyle(color: Colors.green, fontSize: 24),
        ));
  }
}
