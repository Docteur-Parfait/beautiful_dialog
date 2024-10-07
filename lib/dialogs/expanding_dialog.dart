import 'package:beautiful_dialog/widgets/expanding_dialog.dart';
import 'package:flutter/material.dart';

class ExpandingDialogClass {
  static void showExpandingDialog(
    BuildContext context, {
    required String message,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return ExpandingDialog(message: message);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: child,
          ),
        );
      },
    );
  }
}
