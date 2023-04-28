import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData prefixIconData;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obsecureText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    required this.hintText,
    required this.prefixIconData,
    required this.validator,
    this.suffixIcon,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Icon(prefixIconData),
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}
