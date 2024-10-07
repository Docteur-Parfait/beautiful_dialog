import 'package:flutter/material.dart';

class DangerAlert {
  static void showDangerAlertDialog(
    BuildContext context, {
    required String warningMessage,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[50], // Fond rouge pâle pour le danger
          title: const Text(
            'Danger',
            style: TextStyle(color: Colors.red), // Texte rouge
          ),
          content: Text(
            warningMessage,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Bouton rouge
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte
              },
            ),
          ],
        );
      },
    );
  }
}
