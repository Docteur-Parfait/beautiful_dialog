import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../widgets/stackedDialogs/custom_dialog.dart';

class StackedDialogs {
  static final List<String> minimizedDialogs = []; // for later-use
  static final List<CustomDialog> _dialogs = [];
  static int count = 0;

  static void showCustomDialog(BuildContext context, String message) {
    final dialogId = UniqueKey().toString();

    final dialog = CustomDialog(
      dialogId: dialogId,
      content: Center(child: Text(message ?? "Test")),
      onMinimize: () {
        _dialogs.removeWhere((d) => d.dialogId == dialogId);
        (context as Element).markNeedsBuild();
        minimizedDialogs.add(dialogId);
        Navigator.of(context).pop();
      },
    );

    _dialogs.add(dialog);
    showGenericDialog(context);
  }

  static void showGenericDialog(BuildContext context, [String ?message]) {
    count++;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black12,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        double shakeValue = sin(anim1.value * pi * 2) * 16;
        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, shakeValue), // Apply shake translation
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: count == 0 ? ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0) : ImageFilter.blur(sigmaX: 0.25, sigmaY: 0.25),
              child: Stack(
                children: _dialogs,
              )
            ),
          ),
        );
      },
    );
  }

  static void generateDialogs(BuildContext context, int count) {
    for (int i = 1; i <= count; i++) {
      Future.delayed(Duration(milliseconds: i * 250), () {
        showCustomDialog(context, 'Dialog Number $i'); //Needs refactoring
      });
    }
  }

  // For later-use
  static void restoreMinimizedDialog(BuildContext context) {
    if (minimizedDialogs.isNotEmpty) {
      final dialogId = minimizedDialogs.removeLast();
      showGenericDialog(context, 'Récupéré: $dialogId');
    }
  }
}
