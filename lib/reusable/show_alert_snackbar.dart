import 'package:flutter/material.dart';

class ShowAlertSnackbar {

  void showSnackbar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color(0xfff96060),
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
        )));
  }
}
