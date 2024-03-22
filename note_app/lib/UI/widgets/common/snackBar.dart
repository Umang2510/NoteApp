import 'package:flutter/material.dart';

void showSnackBarMessage(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ),
  );
}
