import 'package:flutter/material.dart';

class ShowMessage {
  static void showSnMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
