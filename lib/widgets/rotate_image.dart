import 'dart:math';

import 'package:beautiful_dialog/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RotateImageWidget extends StatefulWidget {
  const RotateImageWidget({super.key});

  @override
  _RotateImageWidgetState createState() => _RotateImageWidgetState();
}

class _RotateImageWidgetState extends State<RotateImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _imagePath = "assets/sun.png";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _imagePath = _imagePath == "assets/sun.png"
              ? "assets/moon.png"
              : "assets/sun.png";
        });
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRotation() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * pi, // Rotation à 360 degrés
              child: Image.asset(
                _imagePath,
                height: 100,
                width: 100,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                themeProvider.isDark ? Colors.grey[900] : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: themeProvider.isDark
                  ? const BorderSide(color: Colors.white)
                  : BorderSide.none,
            ),
          ),
          onPressed: () {
            _startRotation();

            themeProvider.toggleTheme();
          },
          child: Text(
            themeProvider.isDark ? "Light Mode" : "Dark Mode",
            style: TextStyle(
                color: themeProvider.isDark ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
