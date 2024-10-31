import 'dart:ui';
import 'package:beautiful_dialog/dialogs/animated_chart_dialog_content.dart';
import 'package:flutter/material.dart';

class ChartDialog {
  static void showChartDialog(
    BuildContext context, {
    required String title,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        double slideValue = (1 - anim1.value) * 400;
        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, slideValue), // Apply slide up animation
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: ChartDialogContent(title: title),
            ),
          ),
        );
      },
    );
  }
}
