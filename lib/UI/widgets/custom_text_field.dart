import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType ;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLength;

  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    required this.validator,
    this.maxLength,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      maxLength: maxLength,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        errorStyle: const  TextStyle(color: Colors.white),
        fillColor: Colors.white,
        labelStyle:const  TextStyle(color: Colors.white),
        hintStyle: const  TextStyle(color: Colors.white),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
