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
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Wrap(
            children: [
              CustomButton(
                text: "yes or No confirmation",
                author: "Tech Pastor",
                onTap: () => DialogClass.showYesNoConfirmationDialog(context,
                    title: "Confirm", subtitle: "Do you want to confirm"),
              ),
              CustomButton(
                text: "Ok confirmation",
                author: "Tech Pastor",
                onTap: () => DialogClass.showOkConfirmationDialog(context,
                    title: "Confirm", message: "Action confirm successfully"),
              ),
              CustomButton(
                text: "Danger alert",
                author: "Tech Pastor",
                onTap: () => DialogClass.showDangerAlertDialog(context,
                    warningMessage: "Do you want to logout?"),
              ),
            ],
          ),
        )));
  }
}
