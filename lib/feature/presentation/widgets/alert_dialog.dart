import 'package:bt_recipe_management_task/core/constants/string_constant.dart';
import 'package:flutter/material.dart';

class AppAlertDialog {

  /* Show error dialog with message */
  static showError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 8),
              Text(StringConst.error),
            ],
          ),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(StringConst.ok),
            ),
          ],
        );
      },
    );
  }
}