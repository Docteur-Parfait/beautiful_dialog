import 'dart:async';
import 'package:flutter/material.dart';

class ProgressDialog {
  static void showProgressDialog(
    BuildContext context, {
    required String title,
    required List<String> tasks,
    bool autoProgress = true,
    Duration progressDuration = const Duration(seconds: 2),
    VoidCallback? onComplete,
  }) {
    int currentTaskIndex = 0;
    double progress = 0.0;
    Timer? progressTimer;
    bool isPaused = false;
    bool isCompleted = false;

    void startProgress(Function setState) {
      if (!autoProgress) return;

      progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (!isPaused && !isCompleted) {
          setState(() {
            progress += 0.1 / (progressDuration.inSeconds * 10 / tasks.length);

            if (progress >= (currentTaskIndex + 1) / tasks.length) {
              if (currentTaskIndex < tasks.length - 1) {
                currentTaskIndex++;
              } else if (progress >= 1.0) {
                progress = 1.0;
                isCompleted = true;
                timer.cancel();

                Future.delayed(const Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    if (onComplete != null) {
                      onComplete();
                    }
                  }
                });
              }
            }

            if (progress > 1.0) progress = 1.0;
          });
        }
      });
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (progressTimer == null && autoProgress) {
              startProgress(setState);
            }

            return PopScope(
              canPop: false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 16,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.hourglass_empty,
                            color: Colors.blueAccent,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey[200],
                              color: isCompleted ? Colors.green : Colors.blueAccent,
                              strokeWidth: 8,
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? Colors.green : Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          color: isCompleted ? Colors.green : Colors.blueAccent,
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current Task:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (!isCompleted)
                                  const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                if (isCompleted)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    isCompleted
                                        ? 'All tasks completed!'
                                        : tasks[currentTaskIndex],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isCompleted
                                          ? Colors.green
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: List.generate(tasks.length, (index) {
                            bool isDone = index < currentTaskIndex || isCompleted;
                            bool isCurrent = index == currentTaskIndex && !isCompleted;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Icon(
                                    isDone
                                        ? Icons.check_circle
                                        : isCurrent
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                    size: 18,
                                    color: isDone
                                        ? Colors.green
                                        : isCurrent
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      tasks[index],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isDone || isCurrent
                                            ? Colors.black87
                                            : Colors.grey,
                                        fontWeight: isCurrent
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        decoration: isDone
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      if (autoProgress) ...[
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: isCompleted
                                  ? null
                                  : () {
                                      setState(() {
                                        isPaused = !isPaused;
                                      });
                                    },
                              icon: Icon(
                                isPaused ? Icons.play_arrow : Icons.pause,
                                size: 18,
                              ),
                              label: Text(isPaused ? 'Resume' : 'Pause'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {
                                progressTimer?.cancel();
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close, size: 18),
                              label: const Text('Cancel'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (!autoProgress) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              progressTimer?.cancel();
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      progressTimer?.cancel();
    });
  }
}

