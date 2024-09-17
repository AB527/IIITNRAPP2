import 'package:flutter/material.dart';

class Utility {
  static void MobileAlert(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg)
        )
    );
  }
  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}