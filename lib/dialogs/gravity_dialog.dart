import 'package:beautiful_dialog/widgets/feedback_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class GravityDialog {
  //Feedback Dialog
  static void showGravityDialog(BuildContext context) {
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
      transitionDuration: const Duration(milliseconds: 900),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final GravitySimulation gravitySimulation =
            GravitySimulation(10, -150, 0, 0);
        return Transform.translate(
          offset:
              Offset(0, (gravitySimulation.dx(-150 + (150 * animation.value)))),
          child: child,
        );
      },
    );
  }
}
