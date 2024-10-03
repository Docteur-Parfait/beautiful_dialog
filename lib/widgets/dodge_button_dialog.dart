import 'dart:math';
import 'package:flutter/material.dart';

class DodgeButtonDialog extends StatefulWidget {
  final String message;
  const DodgeButtonDialog({super.key, required this.message});

  @override
  DodgeButtonDialogState createState() => DodgeButtonDialogState();
}

class DodgeButtonDialogState extends State<DodgeButtonDialog> {
  double buttonPositionX = 0.0;
  double buttonPositionY = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        buttonPositionX = Random().nextDouble() * MediaQuery.of(context).size.width * 0.5;
        buttonPositionY = Random().nextDouble() * MediaQuery.of(context).size.height * 0.2;
      });
    });
  }

  void moveButton() {
    setState(() {
      buttonPositionX = Random().nextDouble() * MediaQuery.of(context).size.width * 0.5;
      buttonPositionY = Random().nextDouble() * MediaQuery.of(context).size.height * 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          backgroundColor: Colors.green[50],
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/success.png",
                  width: 100,
                  height: 100,
                ),
                const Text(
                  "SUCCESS !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: buttonPositionX,
          top: buttonPositionY,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
            ),
            onPressed: moveButton, // Déplacer le bouton
            child: const Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
