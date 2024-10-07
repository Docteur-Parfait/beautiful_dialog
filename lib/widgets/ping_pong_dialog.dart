import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PingPongDialog extends StatefulWidget {
  final String message;
  const PingPongDialog({Key? key, required this.message}) : super(key: key);

  @override
  _PingPongDialogState createState() => _PingPongDialogState();
}

class _PingPongDialogState extends State<PingPongDialog> {
  double ballX = 0.0;
  double ballY = 0.0;
  double ballSpeedX = 0.01;
  double ballSpeedY = 0.01;
  double paddleX = 0.0;
  double paddleWidth = 0.3;
  int score = 0;
  bool isGameOver = false;

  late Timer gameTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      updateBallPosition();
      checkForCollisions();
    });
  }

  void updateBallPosition() {
    setState(() {
      ballX += ballSpeedX;
      ballY += ballSpeedY;

      // Bounce the ball off the left and right walls
      if (ballX <= -1 || ballX >= 1) {
        ballSpeedX = -ballSpeedX * 1.05;
      }

      // Bounce the ball off the top wall
      if (ballY <= -1) {
        ballSpeedY = -ballSpeedY * 1.05;
      }

      // Check if the ball has passed the paddle (game over)
      if (ballY >= 0.915 && !(ballX >= paddleX && ballX <= paddleX + paddleWidth)) {
        gameOver();
      }
    });
  }

  void checkForCollisions() {
    // Check for collision between the ball and the paddle
    if (ballY >= 0.8 && ballY <=0.9 && ballX >= paddleX && ballX <= paddleX + paddleWidth) {
      setState(() {
        ballSpeedY = -ballSpeedY * 1.15;
        score++;
      });
    }
  }

  void gameOver() {
    setState(() {
      isGameOver = true;
    });
    gameTimer.cancel();
  }

  void restartGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      ballSpeedX = 0.01;
      ballSpeedY = 0.01;
      paddleX = 0;
      score = 0;
      isGameOver = false;
    });
    startGame();
  }

  void handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        setState(() {
          paddleX -= 0.075;
          if (paddleX < -1) paddleX = -1;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        setState(() {
          paddleX += 0.075;
          if (paddleX + paddleWidth > 1) paddleX = 1 - paddleWidth;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        color: Colors.transparent,
        width: 450,
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: handleKeyEvent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Wait message with styled text
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        widget.message,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const LinearProgressIndicator(),
                      const SizedBox(height: 10),
                      const Text(
                        "Play this tiny game while waiting",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal,
                            color: Colors.black54
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Game area
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [Color(0xffffffff), Color(0xfff1efef)],
                      stops: [0.25, 0.75],
                      center: Alignment.center,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        paddleX += details.delta.dx /
                            MediaQuery.of(context).size.width;
                        if (paddleX < -1) paddleX = -1;
                        if (paddleX + paddleWidth > 1) paddleX = 1 - paddleWidth * 1.2;
                      });
                    },
                    child: CustomPaint(
                      painter: PingPongPainter(
                        ballX: ballX,
                        ballY: ballY,
                        paddleX: paddleX,
                        paddleWidth: paddleWidth,
                        isGameOver: isGameOver,
                      ),
                      child: Container(), // The CustomPaint will render the game
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Display the score
                Text('Score: $score', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                // Game Over text and restart button
                if (isGameOver)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: restartGame,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          backgroundColor: Colors.black,
                          elevation: 0,
                          side: const BorderSide(
                              color: Colors.white24,
                              style: BorderStyle.solid,
                              width: 1),
                        ).copyWith(
                          shape: WidgetStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Restart",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Painter class for rendering the game
class PingPongPainter extends CustomPainter {
  final double ballX;
  final double ballY;
  final double paddleX;
  final double paddleWidth;
  final bool isGameOver;

  PingPongPainter({
    required this.ballX,
    required this.ballY,
    required this.paddleX,
    required this.paddleWidth,
    required this.isGameOver,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Draw background
    paint.color = Colors.transparent;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw the ball (black)
    paint.color = Colors.black87;
    canvas.drawCircle(
      Offset(size.width * (ballX + 1) / 2, size.height * (ballY + 1) / 2),
      10, // Ball radius
      paint,
    );

    // Draw the paddle
    paint.color = Colors.black54;
    final paddleLeft = size.width * (paddleX + 1) / 2;
    final paddleTop = size.height * 0.9;
    canvas.drawRect(
      Rect.fromLTWH(paddleLeft, paddleTop, size.width * paddleWidth / 2, 10),
      paint,
    );

    // Game over overlay
    if (isGameOver) {
      paint.color = Colors.black.withOpacity(0.7);
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );
      const textSpan = TextSpan(text: 'Game Over', style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      textPainter.paint(
        canvas,
        Offset((size.width - textPainter.width) / 2,
            (size.height - textPainter.height) / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
