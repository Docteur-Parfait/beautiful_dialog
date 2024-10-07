import 'package:beautiful_dialog/widgets/custom_cancel_btn.dart';
import 'package:flutter/material.dart';

class WarningAlert {
  static void showWarningAlertDialog(
    BuildContext context, {
    required String warningMessage,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: const Color(0xFFffffff),
          title: Column(
            children: [
              Container(
                width: 58.0,
                height: 58.0,
                decoration: const BoxDecoration(
                  color: Color(0xEFEC9C25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'You are about to delete task',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ), // Texte rouge
              ),
            ],
          ),
          content: Text(
            warningMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w300, color: Color(0xFF313131)),
          ),
          actions: const <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCancelButon(
                  icon: Icons.close,
                  bgColor: Colors.white,
                  text: "Cancel",
                  btnTextColor: Color(0xFF5A5A5A),
                ),
                CustomCancelButon(
                  icon: Icons.delete_forever,
                  bgColor: Color(0xFFC02929),
                  text: "Delete",
                  btnTextColor: Colors.white,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
