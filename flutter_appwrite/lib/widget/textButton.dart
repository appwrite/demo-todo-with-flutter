import 'package:flutter/material.dart';

Widget textButton(
  String textString, {
  Function onPressed,
  Color color,
  double size,
  FontWeight fontWeight,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      textString,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    ),
  );
}
