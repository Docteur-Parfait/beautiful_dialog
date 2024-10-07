import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beautiful_dialog/provider/theme_provider.dart';
import 'package:beautiful_dialog/widgets/rotate_image.dart';

class SwitchThemeDialog {
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
}
