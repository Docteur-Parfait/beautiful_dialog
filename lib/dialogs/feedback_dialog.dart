import 'dart:ui';
import 'package:beautiful_dialog/widgets/feedback_dialog_content.dart';
import 'package:flutter/material.dart';

class FeedbackDialog {
  //Feedback Dialog
  static void showFeedbackDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: const EdgeInsets.only(left: 20, top: 20),
          title: const Text(
            "Give us your feedback",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 122, 255),
                    fixedSize: const Size(310, 47),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          content: const FeedbackDialogContent(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: Stack(
              children: [
                Positioned.fill(child: child),
                Positioned.fill(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                            //animate the blur from 25 to 0
                            sigmaX: 25 - 25 * animation.value,
                            sigmaY: 25 - 25 * animation.value),
                        child: const Opacity(
                          opacity: 0,
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}
