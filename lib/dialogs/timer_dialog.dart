import 'dart:async';
import 'package:flutter/material.dart';

class TimerDialog {
  static void showTimerDialog(BuildContext context, {int seconds = 5}) {
    int remainingSeconds = seconds;
    Timer? timer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Initialize the timer only once
            timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
              if (remainingSeconds == 0) {
                timer.cancel();
                Navigator.of(context).pop();
              } else {
                setState(() {
                  remainingSeconds--;
                });
              }
            });

            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 24,
                backgroundColor: Colors.white,
                title: const Row(
                  children: [
                    Icon(Icons.timer, color: Colors.blue),
                    SizedBox(width: 10),
                    Text(
                      "Auto-closing Dialog",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "This dialog will close in $remainingSeconds seconds.",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: remainingSeconds / seconds,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                            strokeWidth: 8,
                          ),
                        ),
                        Text(
                          "$remainingSeconds",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      timer?.cancel();
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      timer?.cancel();
    });
  }
}
