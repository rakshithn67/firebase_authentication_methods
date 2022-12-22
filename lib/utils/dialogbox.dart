import 'package:flutter/material.dart';

showOtpDialog(BuildContext context, TextEditingController controller,
    VoidCallback onPressed) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Enter the OTP',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Done',
            ),
          ),
        ],
      );
    },
  );
}
