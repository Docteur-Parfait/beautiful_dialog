import 'dart:ui';
import 'package:beautiful_dialog/dialogs/app_colors.dart';
import 'package:beautiful_dialog/dialogs/bar_chart.dart';
import 'package:beautiful_dialog/dialogs/pie_chart.dart';
import 'package:beautiful_dialog/dialogs/line_chart.dart';
import 'package:flutter/material.dart';

class ChartDialog {
  static void showChartDialog(
    BuildContext context, {
    required String title,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        double slideValue = (1 - anim1.value) * 400;
        return Center(
          child: Transform(
            transform: Matrix4.identity()..translate(0.0, slideValue),
            alignment: Alignment.center,
            child: ChartDialogContent(title: title),
          ),
        );
      },
    );
  }
}

class ChartDialogContent extends StatefulWidget {
  final String title;

  const ChartDialogContent({super.key, required this.title});

  @override
  State<ChartDialogContent> createState() => _ChartDialogContentState();
}

class _ChartDialogContentState extends State<ChartDialogContent> {
  String selectedChart = 'bar'; // Default to bar chart

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 480,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: selectedChart == 'bar'
                  ? BarChartWidget()
                  : selectedChart == 'pie'
                      ? PieChartWidget()
                      : LineChartWidget(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Chart type selector
                DropdownButton<String>(
                  value: selectedChart,
                  dropdownColor: Colors.black87,
                  style: const TextStyle(color: Colors.white),
                  items: const [
                    DropdownMenuItem(
                      value: 'bar',
                      child: Text('Bar Chart'),
                    ),
                    DropdownMenuItem(
                      value: 'pie',
                      child: Text('Pie Chart'),
                    ),
                    DropdownMenuItem(
                      value: 'line',
                      child: Text('Line Chart'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedChart = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}