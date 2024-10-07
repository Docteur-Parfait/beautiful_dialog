import 'package:flutter/material.dart';

class NotifDialog {
  // Méthode pour afficher la boîte de dialogue "Notification"
  static void showNotifDialog(BuildContext context) {
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
                // Action pour activer les notifications
              },
              child: const Text('Allow notifications'),
            ),
          ],
        );
      },
    );
  }
}
