import 'package:beautiful_dialog/dialogs/animated_confirmation_dialog.dart';
import 'package:beautiful_dialog/dialogs/data_visualization_dialog.dart';
import 'package:beautiful_dialog/dialogs/event_card_dialog.dart';
import 'package:beautiful_dialog/dialogs/gamified_dialog.dart';
import 'package:beautiful_dialog/dialogs/discard_changes_dialog.dart';
import 'package:beautiful_dialog/dialogs/multistep_dialog.dart';
import 'package:beautiful_dialog/dialogs/stacked_dialog.dart';
import 'package:beautiful_dialog/dialogs/timer_dialog.dart';
import 'package:beautiful_dialog/dialogs/voice_input_dialog.dart';
import 'package:beautiful_dialog/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dialogs/dialogs.dart';

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
                text: "Yes or No confirmation",
                author: "Tech Pastor",
                onTap: () => YesOrNoDialog.showYesNoConfirmationDialog(
                  context,
                  title: "Confirm",
                  subtitle: "Do you want to confirm?",
                ),
              ),
              CustomButton(
                text: "Ok confirmation",
                author: "Tech Pastor",
                onTap: () => OkConfirmationDialog.showOkConfirmationDialog(
                  context,
                  title: "Confirm",
                  message: "Action confirmed successfully",
                ),
              ),
              CustomButton(
                text: "Danger alert",
                author: "Tech Pastor",
                onTap: () => DangerAlert.showDangerAlertDialog(
                  context,
                  warningMessage: "Do you want to log out?",
                ),
              ),
              CustomButton(
                text: "Success alert",
                author: "Just2sire",
                onTap: () => SuccesDialog.showSuccessDialog(
                  context,
                  message:
                      "Congrats! You will now enjoy our new updates for next year.",
                ),
              ),
              CustomButton(
                text: "Gamified Dialog",
                author: "Tech Apostle",
                onTap: () => GamifiedDialog.showGamifiedDialog(context),
              ),
              CustomButton(
                text: "Expanding alert",
                author: "littleDarkBug",
                onTap: () => ExpandingDialogClass.showExpandingDialog(
                  context,
                  message: "Try to close it on the first try.",
                ),
              ),
              CustomButton(
                text: "Warning alert",
                author: "gotflo",
                onTap: () => WarningAlert.showWarningAlertDialog(
                  context,
                  warningMessage:
                      "Are you sure you want to delete this post? This action\ncannot be undone.",
                ),
              ),
              CustomButton(
                  text: "Feedback dialog",
                  author: "Prosmaw",
                  onTap: () => FeedbackDialog.showFeedbackDialog(context)),
              CustomButton(
                text: "Switch theme alert",
                author: "Lecodeur",
                onTap: () => SwitchThemeDialog.showSwitchThemeDialog(context),
              ),
              CustomButton(
                text: "Error Alert",
                author: "shubhanshu-02",
                onTap: () => ErrorDialog.showErrorDialog(
                  context,
                  message: "An error occurred while processing your request.",
                ),
              ),
              CustomButton(
                text: "Show notification Dialog",
                author: "Armel Bogue",
                onTap: () => NotifDialog.showNotifDialog(context),
              ),
              CustomButton(
                text: "PingPong Dialog",
                author: "littleDarkBug",
                onTap: () => PingPongDialog.showPingPongDialog(
                  context,
                  message: "Please, wait while we're doing the magic!",
                ),
              ),
              CustomButton(
                  text: "Discard Changes dialog",
                  author: "Shubhanshu-02",
                  onTap: () => DiscardChangesDialog.showDiscardDialog(context)),
              CustomButton(
                  text: "Stacked dialogs",
                  author: "littleDarkBug",
                  onTap: () => StackedDialogs.generateDialogs(context, 10)),
              CustomButton(
                  text: "Paiement dialog",
                  author: "Tech Pastor",
                  onTap: () => PaiementDialog.paiementDialog(context)),
              CustomButton(
                text: "Butterfly Dialog",
                author: "dev1abhi",
                onTap: () =>
                    ButterflyDialogManager.showFlyingButterfliesDialog(context),
              ),
              CustomButton(
                text: "Loading dialog",
                author: "LeScientifique",
                onTap: () => LoadingDialog.showLoadingDialog(context,
                    message: "Loading..."),
              ),
              CustomButton(
                text: "Tutorial dialog",
                author: "LeScientifique",
                onTap: () => TutorialDialog.showTutorialDialog(context, steps: [
                  "Cliquer sur un composant pour un prewiew",
                  "Cliquer sur le bouton en haut à droite pour contribuer"
                ]),
              ),
              CustomButton(
                text: "Multi-step Dialog",
                author: "Tech Apostle",
                onTap: () => MultiStepDialog.showMultiStepDialog(context),
              ),
              CustomButton(
                text: "Timer Dialog",
                author: "Tech Apostle",
                onTap: () => TimerDialog.showTimerDialog(context, seconds: 5),
              ),
              CustomButton(
                text: "Voice Input Dialog",
                author: "Tech Apostle",
                onTap: () => VoiceInputDialog.showVoiceInputDialog(context),
              ),
              CustomButton(
                text: "Animated Confirmation Dialog",
                author: "Tech Apostle",
                onTap: () =>
                    AnimatedConfirmationDialog.showAnimatedConfirmationDialog(
                  context,
                  title: "Confirm Action",
                  message: "Are you sure you want to proceed with this action?",
                  onConfirm: () {},
                  onCancel: () {},
                ),
              ),
              CustomButton(
                text: "Event Cards Dialog",
                author: "Tech Apostle",
                onTap: () => EventCardDialog.showEventCardDialog(context),
              ),
              CustomButton(
                text: "Data Visualization Dialog",
                author: "Tech Apostle",
                onTap: () =>
                    DataVisualizationDialog.showDataVisualizationDialog(
                        context),
              ),
              CustomButton(
                text: "Widget Tour Dialog",
                author: "LeScientifique",
                onTap: () {
                  List<WidgetItem> widgetItems =
                      WidgetExtractor.extractWidgetItemsFromContext(context);
                  if (widgetItems.isNotEmpty) {
                    WidgetTourDialog.showWidgetTourDialog(
                      context,
                      widgetItems: widgetItems,
                    );
                  } else {
                    // Afficher un message d'erreur ou gérer l'absence de widgets
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Aucun widget disponible pour le tour.')),
                    );
                  }
                },
              ),
              CustomButton(
                  text: "Avatar picker dialog",
                  author: "Prosmaw",
                  onTap: () => AvatarPicker.showAvatarPickerDialog(context)),
            ],
          ),
        ),
      ),
    );
  }
}
