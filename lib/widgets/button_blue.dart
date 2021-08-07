import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final void Function() onPress;
  final String text;

  const ButtonBlue({
    required this.onPress,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        elevation: 3,
        backgroundColor: Colors.blue,
        shape: StadiumBorder()
      ),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text, style: TextStyle( color: Colors.white, fontSize: 17),),
        ),
      ),
    );
  }
}