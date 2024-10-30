import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class FeedbackDialogBox {
  static void showFeedbackDialogs(
    BuildContext context, {
    required String message,
  }) {
    final TextEditingController commentController = TextEditingController();
    int selectedFeeling = 2; // Default to 'Medium'

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, anim1, anim2) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "How are you feeling?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Subtitle
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                // Feelings row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(5, (index) {
                    final List<IconData> feelingIcons = [
                      Icons.sentiment_very_dissatisfied,
                      Icons.sentiment_dissatisfied,
                      Icons.sentiment_neutral,
                      Icons.sentiment_satisfied,
                      Icons.sentiment_very_satisfied,
                    ];

                    final List<String> feelingLabels = [
                      "Very Bad",
                      "Bad",
                      "Medium",
                      "Good",
                      "Very Good",
                    ];

                    return GestureDetector(
                      onTap: () {
                        selectedFeeling = index;
                        (context as Element).markNeedsBuild();
                      },
                      child: Column(
                        children: [
                          Icon(
                            feelingIcons[index],
                            size: 40,
                            color: selectedFeeling == index
                                ? Colors.green
                                : Colors.grey,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            feelingLabels[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: selectedFeeling == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selectedFeeling == index
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Comment section
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    labelText: "Add a Comment...",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                // Submit button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // Handle submit action
                    print("Feedback: $selectedFeeling");
                    print("Comment: ${commentController.text}");
                    Navigator.pop(context); // Close dialog
                  },
                  child: Text("Submit Now"),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        double shakeValue = sin(anim1.value * pi * 2) * 10;

        return Center(
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, shakeValue),
            alignment: Alignment.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
