import 'package:flutter/material.dart';

SnackBar createErrorSnackBar(String? content) {
  return SnackBar(
    backgroundColor: Colors.red[900],
    content: Text(content ?? 'An error occurred'),
  );
}
