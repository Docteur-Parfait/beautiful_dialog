import 'dart:js' as js;

import 'package:beautiful_dialog/dialogs/dialog_class.dart';
import 'package:beautiful_dialog/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DialogView extends StatefulWidget {
  const DialogView({super.key});

  @override
  State<DialogView> createState() => _DialogViewState();
}

class _DialogViewState extends State<DialogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Beautiful Dialogs"),
        actions: [
          GestureDetector(
            onTap: () {
              js.context.callMethod('open',
                  ['https://github.com/Docteur-Parfait/beautiful_dialog.git']);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/github.png",
                      height: 30,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      "Contribute",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            children: [
              CustomButton(
                text: "yes or No confirmation",
                author: "Tech Pastor",
                onTap: () => DialogClass.showYesNoConfirmationDialog(
                  context,
                  title: "Confirm",
                  subtitle: "Do you want to confirm",
                ),
              ),
              CustomButton(
                text: "Ok confirmation",
                author: "Tech Pastor",
                onTap: () => DialogClass.showOkConfirmationDialog(
                  context,
                  title: "Confirm",
                  message: "Action confirm successfully",
                ),
              ),
              CustomButton(
                text: "Danger alert",
                author: "Tech Pastor",
                onTap: () => DialogClass.showDangerAlertDialog(
                  context,
                  warningMessage: "Do you want to logout?",
                ),
              ),
              CustomButton(
                text: "Success alert",
                author: "Just2sire",
                onTap: () => DialogClass.showSuccessDialog(
                  context,
                  message:
                      "Congrats! You will now enjoy our new updates for next year.",
                ),
              ),
              CustomButton(
                text: "Expanding alert",
                author: "littleDarkBug",
                onTap: () => DialogClass.showExpandingDialog(
                  context,
                  message: "Try to close it at first try.",
                ),
              ),
              CustomButton(
                text: "Warning alert",
                author: "gotflo",
                onTap: () => DialogClass.showWarningAlertDialog(
                  context,
                  warningMessage:
                      "Are you sure you want to delete this post? this action\ncannot be undone.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
