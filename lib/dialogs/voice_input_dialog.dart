import 'package:flutter/material.dart';
// import 'dart:html' as html;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class VoiceInputDialog {
  static void showVoiceInputDialog(BuildContext context) {
    bool isListening = false;
    String recognizedWords = '';
    bool speechAvailable = false;
    // html.MediaStream? mediaStream;

    Future<bool> requestMicrophonePermission() async {
      try {
        // mediaStream = await html.window.navigator.getUserMedia(audio: true);
        return true;
      } catch (e) {
        return false;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Center(
                child: Text(
                  "Voice Input",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isListening ? "Listening..." : "Press the mic to speak",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  if (isListening) const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    recognizedWords,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (!speechAvailable)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Speech recognition not available",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  if (isListening)
                    SizedBox(
                      height: 100,
                      child: WaveWidget(
                        config: CustomConfig(
                          gradients: [
                            [Colors.blue, Colors.lightBlueAccent],
                            [Colors.blueAccent, Colors.blue],
                          ],
                          durations: [35000, 19440],
                          heightPercentages: [0.20, 0.23],
                          blur: const MaskFilter.blur(BlurStyle.solid, 10),
                          gradientBegin: Alignment.bottomLeft,
                          gradientEnd: Alignment.topRight,
                        ),
                        waveAmplitude: 0,
                        size: const Size(double.infinity, double.infinity),
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(isListening ? Icons.mic_off : Icons.mic),
                  onPressed: () async {
                    if (!isListening) {
                      bool permissionGranted =
                          await requestMicrophonePermission();
                      if (!permissionGranted) {
                        setState(() => speechAvailable = false);
                        return;
                      }
                      setState(() => speechAvailable = true);
                      setState(() => isListening = true);
                      // Start recording and handle the result
                      // You can use mediaStream to access the audio data
                    } else {
                      setState(() => isListening = false);
                      // Stop recording and handle the result
                      // mediaStream?.getTracks().forEach((track) {
                      //   track.stop();
                      // });
                    }
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    if (isListening) {
                      // mediaStream?.getTracks().forEach((track) {
                      //   track.stop();
                      // });
                    }
                    setState(() {
                      recognizedWords = '';
                      isListening = false;
                    });
                  },
                  child: const Text("Retry"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    if (isListening) {
                      // mediaStream?.getTracks().forEach((track) {
                      //   track.stop();
                      // });
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(recognizedWords);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
