import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData iconData;
  final String placeholder;
  final TextEditingController texController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput(
      {Key? key,
      required this.iconData,
      required this.placeholder,
      required this.texController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ]),
      child: TextField(
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isPassword,
        controller: texController,
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeholder,
        ),
      ),
    );
  }
}
