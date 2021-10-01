import 'package:flutter/material.dart';

Widget textFormField({
  TextEditingController controller,
  String hintText,
  TextInputType keyboardType,
  Color textColor,
  bool obscureText,
  Function(String) validator,
}) {
  return TextFormField(
    validator: validator,
    obscureText: obscureText ?? false,
    keyboardType: keyboardType,
    style: TextStyle(
      color: textColor ?? Colors.black,
    ),
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.2),
    ),
  );
}
