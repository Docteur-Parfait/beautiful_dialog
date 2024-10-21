// lib/dialog_manager.dart
import 'package:beautiful_dialog/widgets/butterfly_dialog_content.dart';
import 'package:flutter/material.dart';

class ButterflyDialogManager {
  static void showFlyingButterfliesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          // Ensure the dialog content is centered
          child: Material(
            type: MaterialType
                .transparency, // Makes background of the dialog transparent
            child:
                FlyingButterfliesDialog(), // Return the dialog content directly
          ),
        );
      },
    );
  }
}
