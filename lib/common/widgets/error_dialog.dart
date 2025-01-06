import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add your logo/image here
          Image.asset(
            "assets/icons/light_icon.png",
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: TColors.primaryColor,
            padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Retry'),
        ),
      ],
    );
  }
}
