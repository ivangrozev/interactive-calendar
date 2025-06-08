import 'package:flutter/material.dart';

class UiService {
  void successSnackBar(String text, BuildContext context) {
    _snackBar(text, context, Colors.green);
  }

  void errorSnackBar(String text, BuildContext context) {
    _snackBar(text, context, Colors.red);
  }

  _snackBar(String text, BuildContext context, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(color: color),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}