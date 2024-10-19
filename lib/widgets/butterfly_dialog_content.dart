

import 'package:flutter/material.dart';
import 'dart:math';

class FlyingButterfliesDialog extends StatefulWidget {
  const FlyingButterfliesDialog({super.key});

  @override
  _FlyingButterfliesDialogState createState() => _FlyingButterfliesDialogState();
}



class _FlyingButterfliesDialogState extends State<FlyingButterfliesDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: ButterflyClipper(),
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.purple.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(

              left: 50,
              bottom: 160,

              child: Text(
                "Enjoy the Butterflies!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
              ),
            ),
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    children: List.generate(5, (index) {
                      final xOffset = _animation.value * 300;
                      final yOffset = sin(_animation.value * 2 * pi + index) * 200 + 150;

                      return Positioned(
                        left: xOffset,
                        top: yOffset,
                        child: Transform.rotate(
                          angle: _animation.value * 2 * pi,
                          child: Image.asset(
                            'assets/butterfly.png',
                            width: 30,
                            height: 30,
                            color: Colors.purple.shade400,
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Positioned(
              left: 110,
              bottom: 30,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButterflyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // left wing
    path.moveTo(size.width / 2, size.height / 2);
    path.quadraticBezierTo(0, size.height * 0.25, size.width * 0.15, size.height / 2);
    path.quadraticBezierTo(0, size.height * 0.75, size.width / 2, size.height);

    //right wing
    path.moveTo(size.width / 2, size.height / 2);
    path.quadraticBezierTo(size.width, size.height * 0.25, size.width * 0.85, size.height / 2);
    path.quadraticBezierTo(size.width, size.height * 0.75, size.width / 2, size.height);



    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


