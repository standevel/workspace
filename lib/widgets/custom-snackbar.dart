import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {super.key,
      required String message,
      required IconData iconData,
      required VoidCallback onClose,
      color = Colors.blue})
      : super(
          content: Container(
            constraints: const BoxConstraints(
              maxWidth: 200, // Limiting the width to 200
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          backgroundColor: color, // Change the background color as needed
          behavior: SnackBarBehavior.floating, // Height fits content
        );
}
