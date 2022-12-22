import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String textField;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType textInputType;

  const TextInputField({
    Key? key,
    required this.textField,
    required this.controller,
    required this.isPassword,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(
            10,
          ),
          hintText: textField,
          hintStyle: const TextStyle(
            color: Colors.black54,
          ),
          border: const OutlineInputBorder(
              // borderSide: Divider.createBorderSide(context),
              ),
          enabledBorder: const OutlineInputBorder(
              // borderSide: Divider.createBorderSide(context),
              ),
          focusedBorder: const OutlineInputBorder(
              // borderSide: Divider.createBorderSide(context),
              ),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
