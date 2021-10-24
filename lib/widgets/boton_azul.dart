import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const BotonAzul({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        elevation: 2,
        shape: const StadiumBorder(),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
