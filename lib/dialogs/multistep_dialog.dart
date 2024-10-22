import 'package:flutter/material.dart';

class MultiStepDialog {
  static void showMultiStepDialog(BuildContext context) {
    int currentStep = 0;
    List<String> steps = [
      "What's your name?",
      "What's your age?",
      "What's your favorite color?",
      "What's your hobby?",
      "What's your dream job?"
    ];
    List<String> answers = ["", "", "", "", ""];
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            textController.text = answers[currentStep];
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Column(
                children: [
                  Text("Step ${currentStep + 1}/${steps.length}"),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentStep + 1) / steps.length,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 10,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(steps[currentStep]),
                  const SizedBox(height: 20),
                  TextField(
                    controller: textController,
                    onChanged: (value) {
                      answers[currentStep] = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      hintText: 'Enter your answer',
                    ),
                  ),
                ],
              ),
              actions: [
                if (currentStep > 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        currentStep--;
                        textController.text = answers[currentStep];
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text("Previous"),
                  ),
                TextButton(
                  onPressed: () {
                    if (answers[currentStep].isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter an answer"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    if (currentStep < steps.length - 1) {
                      setState(() {
                        currentStep++;
                        textController.clear();
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text("Summary"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 0; i < steps.length; i++)
                                  ListTile(
                                    title: Text(steps[i]),
                                    subtitle: Text(answers[i]),
                                  ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey,
                                ),
                                child: const Text("Edit"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Submitted successfully!"),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                ),
                                child: const Text("Submit"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child:
                      Text(currentStep < steps.length - 1 ? "Next" : "Finish"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
