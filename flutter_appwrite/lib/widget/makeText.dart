import 'package:flutter/material.dart';

Widget makeText(
  String textString, {
  Color color,
  double size,
  FontWeight fontWeight,
  TextOverflow overflow,
}) {
  return Text(
    textString,
    overflow: overflow ?? TextOverflow.ellipsis,
    maxLines: 3,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}
