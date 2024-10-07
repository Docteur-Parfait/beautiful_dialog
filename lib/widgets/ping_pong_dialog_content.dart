import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PingPongDialogContent extends StatefulWidget {
  final String message;

  const PingPongDialogContent({super.key, required this.message});

  @override
  PingPongDialogContentState createState() => PingPongDialogContentState();
}

class PingPongDialogContentState extends State<PingPongDialogContent> {
  double ballX = 0.0;
  double ballY = 0.0;
  double ballSpeedX = 0.005;
  double ballSpeedY = 0.005;
  double paddleX = 0.0;
  double paddleWidth = 0.3;
  int score = 0;
  bool isGameOver = false;
  bool isPlaying = false;

  final GlobalKey _keyContainer = GlobalKey();

  late Timer gameTimer;

  @override
  void initState() {
    super.initState();
  }

  void startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 12), (timer) {
      updateBallPosition();
      checkForCollisions();
    });
    isPlaying = true;
  }

  void updateBallPosition() {
    setState(() {
      // Calculate the next potential positions
      double nextBallX = ballX + ballSpeedX;
      double nextBallY = ballY + ballSpeedY;

      // Check and adjust ball position based on boundaries
      nextBallX = _checkHorizontalBoundaries(nextBallX);
      nextBallY = _checkVerticalBoundaries(nextBallY);

      // Update ball position
      ballX = nextBallX;
      ballY = nextBallY;
    });
  }

  double _checkHorizontalBoundaries(double nextBallX) {
    if (nextBallX <= -1) {
      ballSpeedX = -ballSpeedX; // Reverse direction
      return -1;
    }
    if (nextBallX >= 1) {
      ballSpeedX = -ballSpeedX;
      return 1;
    }
    return nextBallX;
  }

  double _checkVerticalBoundaries(double nextBallY) {
    if (nextBallY <= -1) {
      ballSpeedY = -ballSpeedY * 1.05; // Reverse direction with speed boost
      return -1;
    }
    if (nextBallY >= 0.91) {
      ballY = 0.98;
      gameOver();
    }
    return nextBallY;
  }

  void checkForCollisions() {
    // Check for collision between the ball and the paddle
    if (ballY >= 0.8 &&
        ballY <= 0.88 &&
        ballX >= paddleX &&
        ballX <= paddleX + paddleWidth) {
      setState(() {
        ballSpeedY = -ballSpeedY;
        ballY = (ballY + ballSpeedY) > 1 ? 0.95 : ballY; // low rate case
        score++;
      });
    }
  }

  void gameOver() {
    setState(() {
      isGameOver = true;
      isPlaying = false;
    });
    gameTimer.cancel();
  }

  void restartGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      ballSpeedX = 0.006;
      ballSpeedY = 0.006;
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
          paddleX -= 0.09;
          if (paddleX < -1) paddleX = -1;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        setState(() {
          paddleX += 0.09;
          if (paddleX + paddleWidth > 1) paddleX = 1 - paddleWidth;
        });
      }
    }
  }

  void onTapDown(TapDownDetails details) {
    setState(() {
      paddleX = _calculatePaddleX(details.localPosition.dx);
    });
  }

  void onHorizontalDrag(DragUpdateDetails details) {
    setState(() {
      paddleX += (details.delta.dx * 1.02) / _getContainerWidth();

      // Clamp paddleX to stay within bounds
      paddleX = _clampPaddleX(paddleX);
    });
  }

  double _getContainerWidth() {
    final RenderBox renderBox =
        _keyContainer.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.width;
  }

  double _calculatePaddleX(double tapX) {
    final width = _getContainerWidth();
    double newPaddleX = (tapX / width) * 2 - 1; // Convert to range -1 to 1
    return _clampPaddleX(newPaddleX); // Clamp the new paddleX value
  }

  double _clampPaddleX(double x) {
    if (x < -1) return -1;
    if (x + paddleWidth > 1) return 1 - paddleWidth;
    return x;
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    gameTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        color: Colors.transparent,
        width: 480,
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
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const LinearProgressIndicator(),
                      const SizedBox(height: 10),
                      const Text(
                        "Play this tiny game while waiting",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Game area
                Container(
                  height: 300,
                  width: 460,
                  key: _keyContainer,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [Color(0xffffffff), Color(0xfff1efef)],
                      stops: [0.25, 0.75],
                      center: Alignment.center,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onHorizontalDragUpdate: onHorizontalDrag,
                      onTapDown: onTapDown,
                      child: CustomPaint(
                        painter: PingPongPainter(
                          ballX: ballX,
                          ballY: ballY,
                          paddleX: paddleX,
                          paddleWidth: paddleWidth,
                          isGameOver: isGameOver,
                        ),
                        child:
                        Container(), // The CustomPaint will render the game
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 20),
                // Display the score
                Text('Score: $score', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                if (!isPlaying)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: isGameOver ? restartGame : startGame,
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          isGameOver ? "Restart" : "Start",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
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
        fontSize: 24,
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
