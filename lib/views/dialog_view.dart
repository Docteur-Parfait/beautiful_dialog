import 'package:beautiful_dialog/dialogs/dialog_class.dart';
import 'package:beautiful_dialog/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogView extends StatefulWidget {
  const DialogView({super.key});

  @override
  State<DialogView> createState() => _DialogViewState();
}

class _DialogViewState extends State<DialogView> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Beautiful Dialogs"),
        actions: [
          GestureDetector(
            onTap: () {
              _launchUrl(
                  'https://github.com/Docteur-Parfait/beautiful_dialog.git');
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

              CustomButton(
                text: "Switch theme alert",
                author: "Lecodeur",
                onTap: () => DialogClass.showSwitchThemeDialog(
                  context,
                ),
              ),
              CustomButton(
                text: "Show notification Dialog",
                author: "Armel Bogue",
                onTap: () => showVenmoDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour afficher la boîte de dialogue "Venmo"
  void showVenmoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.notifications_active,
                size: 50,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 16.0),
              Text(
                'Get a heads up on everything',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Find out when you get paid or receive payment requests. Get updates on new features, discounts, and promos.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8.0),
              Text(
                'You can change this at any time in Settings.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Not now'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                
              },
              child: const Text('Allow notifications'),
            ),
          ],
        );
      },
    );
  }
}
