import 'package:flutter/material.dart';

customSnackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(14),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(message),
        ],
      ),
    ),
  );
}
