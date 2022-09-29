import 'package:flutter/material.dart';

class CustomShowSnackBar {
  static basicSnackBar(
      BuildContext context, Color backgroundColor, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2)));
  }
}
