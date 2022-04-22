import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget elevatedButton(
  BuildContext context,
  String textElevated, {
  Function onPressed,
  double textSize,
  Size size,
}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: size,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          primary: Colors.red,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textSize ?? 20,
          )),
      onPressed: onPressed,
      child: Text(textElevated));
}
