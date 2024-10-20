import 'package:flutter/material.dart';

class TutorialDialog {
  static void showTutorialDialog(
    BuildContext context, {
    required List<String> steps,
  }) async {
    int currentStep = 0;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Empêche de fermer en cliquant à l'extérieur
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Tutoriel'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Étape ${currentStep + 1}'),
                  const SizedBox(height: 10),
                  Text(steps[currentStep]),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: currentStep > 0
                      ? () {
                          setState(() {
                            currentStep--;
                          });
                        }
                      : null,
                  child: const Text('Précédent'),
                ),
                ElevatedButton(
                  onPressed: currentStep < steps.length - 1
                      ? () {
                          setState(() {
                            currentStep++;
                          });
                        }
                      : null,
                  child: const Text('Suivant'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Terminer'),
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
