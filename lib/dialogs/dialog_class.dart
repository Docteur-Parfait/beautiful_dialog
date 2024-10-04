import 'package:flutter/material.dart';

import '../widgets/custom_cancel_btn.dart';
import '../widgets/expanding_dialog.dart';

class DialogClass {
  // add your dialog here as a static method
  static void showYesNoConfirmationDialog(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Couleur personnalisée pour Yes
              ),
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showOkConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Couleur bleue pour Ok
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte
              },
            ),
          ],
        );
      },
    );
  }

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

  static void showSuccessDialog(
    BuildContext context, {
    required String message,
  }) async {
    bool isDesktop = MediaQuery.of(context).size.width >= 1024.0;
    Size size = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.green[50],
          child: Container(
            height: isDesktop ? size.height * 0.5 : size.height * 0.5,
            width: isDesktop ? size.width * 0.18 : size.width * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/success.png",
                  width: isDesktop ? 150 : 100,
                  height: isDesktop ? 150 : 100,
                ),
                const Text(
                  "SUCCESS !",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showExpandingDialog(
    BuildContext context, {
    required String message,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return ExpandingDialog(message: message);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: child,
          ),
        );
      },
    );
  }


  static void comradeIsThere(BuildContext context,
      {required String message}) async {
    bool isDesktop = MediaQuery.of(context).size.width >= 1024.0;
    Size size = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.green[50],
          child: Container(
            height: isDesktop ? size.height * 0.5 : size.height * 0.5,
            width: isDesktop ? size.width * 0.18 : size.width * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/comrade-is-happy.png",
                  width: isDesktop ? 150 : 100,
                  height: isDesktop ? 150 : 100,
                ),
                const Text(
                  "Comrade is there...",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 73, 130, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color.fromARGB(255, 73, 130, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Yesss",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

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
