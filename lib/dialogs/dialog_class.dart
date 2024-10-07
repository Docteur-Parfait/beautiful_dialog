import 'dart:math';
import 'dart:ui';

import 'package:beautiful_dialog/provider/theme_provider.dart';
import 'package:beautiful_dialog/widgets/rotate_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beautiful_dialog/widgets/ping_pong_dialog.dart';

class DialogClass {
  // add your dialog here as a static method
  static showSwitchThemeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return AlertDialog(
                backgroundColor:
                    themeProvider.isDark ? Colors.grey[900] : Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                title: Text(
                  'Theme Switch Dialog',
                  style: TextStyle(
                      color:
                          themeProvider.isDark ? Colors.white : Colors.black),
                ),
                content: const RotateImageWidget(),
              );
            },
          );
        });
  }

  static void showErrorDialog(
    BuildContext context, {
    required String message,
  }) async {
    bool isDesktop = MediaQuery.of(context).size.width >= 1024.0;
    Size size = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.red[50],
          child: Container(
            height: isDesktop ? size.height * 0.5 : size.height * 0.5,
            width: isDesktop ? size.width * 0.18 : size.width * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/error.png", // Error image asset
                  width: isDesktop ? 150 : 100,
                  height: isDesktop ? 150 : 100,
                ),
                const Text(
                  "Oops!",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
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
                    backgroundColor: Colors.red,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
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

  static void showPingPongDialog(
    BuildContext context, {
    required String message,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        double shakeValue = sin(anim1.value * 2 * pi * 2) * 10;
        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, shakeValue), // Apply shake translation
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: PingPongDialog(message: message),
            ),
          ),
        );
      },
    );
  }
}
