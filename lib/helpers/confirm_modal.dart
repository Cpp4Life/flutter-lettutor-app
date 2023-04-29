import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/styles/index.dart';

class ConfirmModal {
  static Future show({
    required BuildContext context,
    required String title,
    required String actionTitle,
    required Function callback,
  }) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(
          title,
          style: const TextStyle(
            fontSize: LetTutorFontSizes.px14,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: LetTutorColors.primaryRed),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              callback();
              Navigator.pop(context);
            },
            child: Text(actionTitle),
          ),
        ],
      ),
    );
  }
}
