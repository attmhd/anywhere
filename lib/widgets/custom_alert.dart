import 'package:flutter/material.dart';

// Custom Alert Dialog
Future<void> showCustomAlert({
  required BuildContext context,
  required String title,
  required String message,
  IconData? icon,
  Color? iconColor,
  String buttonText = "OK",
  VoidCallback? onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor ?? Colors.blue, size: 28),
              SizedBox(width: 10),
            ],
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(message, style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            child: Text(buttonText, style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    },
  );
}
