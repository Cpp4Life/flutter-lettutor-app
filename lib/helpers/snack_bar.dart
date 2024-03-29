import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../core/styles/index.dart';

class TopSnackBar {
  static const TextStyle _style = TextStyle(
    fontSize: LetTutorFontSizes.px16,
    fontWeight: LetTutorFontWeights.medium,
    color: Colors.white,
  );

  static _show({
    required BuildContext context,
    required String message,
    bool isSuccess = true,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      isSuccess
          ? CustomSnackBar.success(
              message: message,
              textStyle: _style,
            )
          : CustomSnackBar.error(
              message: message,
              textStyle: _style,
            ),
      displayDuration: const Duration(milliseconds: 500),
    );
  }

  static showError(BuildContext context, String message) {
    _show(context: context, message: message, isSuccess: false);
  }

  static showSuccess(BuildContext context, String message) {
    _show(context: context, message: message, isSuccess: true);
  }
}
