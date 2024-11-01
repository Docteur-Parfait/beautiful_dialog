import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';

class GamifiedDialog {
  static void showGamifiedDialog(BuildContext context) {
    int score = 0;
    int highestScore = 0;
    int targetNumber = Random().nextInt(10) + 1;
    Timer? timer;
    int timeLeft = 30;
    AudioPlayer audioPlayer = AudioPlayer();
    AudioPlayer backgroundMusicPlayer = AudioPlayer();

    void playSound(String sound) {
      audioPlayer.play(AssetSource(sound));
    }

    void playBackgroundMusic() {
      backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
      backgroundMusicPlayer.play(AssetSource('background_music.ogg'));
    }

    void stopBackgroundMusic() {
      backgroundMusicPlayer.stop();
    }

    void startTimer(Function setState) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (timeLeft > 0) {
            timeLeft--;
          } else {
            timer.cancel();
            stopBackgroundMusic();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Center(
                    child: Text(
                      "Time's Up!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'CustomFont',
                      ),
                    ),
                  ),
                  content: const Text(
                    "Would you like to try again?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'CustomFont',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                      ),
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        "Try Again",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        startTimer(setState);
                      },
                    ),
                  ],
                );
              },
            );
          }
        });
      });
    }

    void showTryAgainDialog(BuildContext context, Function setState) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Center(
              child: Text(
                "Time's Up!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'CustomFont',
                ),
              ),
            ),
            content: const Text(
              "Would you like to try again?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'CustomFont',
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    score = 0;
                    targetNumber = Random().nextInt(10) + 1;
                    timeLeft = 30;
                    startTimer(setState);
                    playBackgroundMusic();
                  });
                },
              ),
            ],
          );
        },
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (timer == null) {
              startTimer(setState);
              playBackgroundMusic();
            }
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Center(
                child: Text(
                  "Guess the Number Game",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'CustomFont',
                  ),
                ),
              ),
              content: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.lightGreenAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Guess a number between 1 and 10",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'CustomFont'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Score: $score",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CustomFont'),
                    ),
                    Text(
                      "Highest Score: $highestScore",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CustomFont'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Time Left: $timeLeft",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.redAccent,
                          fontFamily: 'CustomFont'),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: List.generate(10, (index) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'CustomFont'),
                          ),
                          onPressed: () {
                            if (index + 1 == targetNumber) {
                              setState(() {
                                score++;
                                if (score > highestScore) {
                                  highestScore = score;
                                }
                                targetNumber = Random().nextInt(10) + 1;
                                timeLeft = 30;
                              });
                              playSound('correct.ogg');
                              BotToast.showText(
                                  text: "Correct! New number generated.");
                            } else {
                              playSound('wrong.ogg');
                              BotToast.showText(
                                  text: "Wrong guess. Try again!");
                            }
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    timer?.cancel();
                    stopBackgroundMusic();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
