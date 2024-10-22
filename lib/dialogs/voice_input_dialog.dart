import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceInputDialog {
  static void showVoiceInputDialog(BuildContext context) {
    stt.SpeechToText speech = stt.SpeechToText();
    bool isListening = false;
    String recognizedWords = '';
    bool speechAvailable = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text("Voice Input"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isListening ? "Listening..." : "Press the mic to speak"),
                  const SizedBox(height: 20),
                  if (isListening)
                    const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    recognizedWords,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (!speechAvailable)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Speech recognition not available",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(isListening ? Icons.mic_off : Icons.mic),
                  onPressed: () async {
                    if (!isListening) {
                      bool available = await speech.initialize();
                      setState(() => speechAvailable = available);
                      if (available) {
                        setState(() => isListening = true);
                        speech.listen(
                          onResult: (result) {
                            setState(() {
                              recognizedWords = result.recognizedWords;
                            });
                          },
                        );
                      }
                    } else {
                      setState(() => isListening = false);
                      speech.stop();
                    }
                  },
                ),
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    if (isListening) {
                      speech.stop();
                    }
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(recognizedWords);
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