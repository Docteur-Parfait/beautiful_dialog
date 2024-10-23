import 'package:beautiful_dialog/widgets/avatar_picker/dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AvatarPicker {
  //Feedback Dialog
  static void showAvatarPickerDialog(BuildContext context) {
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
          title: const Center(
            child: Text(
              "Choose a disc",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 23, 23, 26),
                    fixedSize: const Size(310, 47),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          content: const DialogContent(),
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
