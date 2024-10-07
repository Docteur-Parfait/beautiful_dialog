import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:beautiful_dialog/widgets/ping_pong_dialog.dart';

class DialogClass {
  // add your dialog here as a static method
  static void showPingPongDialog(
    BuildContext context, {
    required String message,
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
        double shakeValue = sin(anim1.value * 2 * pi * 2) * 10;
        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, shakeValue), // Apply shake translation
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: PingPongDialog(message: message),
            ),
          ),
        );
      },
    );
  }
}
