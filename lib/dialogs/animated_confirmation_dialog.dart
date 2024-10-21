import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class AnimatedConfirmationDialog {
  static void showAnimatedConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: anim1,
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeInOut,
            ),
            child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          message,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                onCancel();
                                BotToast.showText(
                                  text: "Action cancelled.",
                                  contentColor: Colors.redAccent,
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                onConfirm();
                                BotToast.showText(
                                  text: "Action confirmed!",
                                  contentColor: Colors.greenAccent,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                              ),
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
