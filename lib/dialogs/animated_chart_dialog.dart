import 'dart:ui';
import 'package:beautiful_dialog/dialogs/app_colors.dart';
import 'package:beautiful_dialog/dialogs/bar_chart.dart';
import 'package:beautiful_dialog/dialogs/pie_chart.dart';
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
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: ChartDialogContent(title: title),
            ),
          ),
        );
      },
    );
  }
}

class ChartDialogContent extends StatefulWidget {
  final String title;

  const ChartDialogContent({
    super.key,
    required this.title,
  });

  @override
  State<ChartDialogContent> createState() => _ChartDialogContentState();
}

class _ChartDialogContentState extends State<ChartDialogContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: AppColors.mainTextColor1,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  BarChartWidget(),
                  const PieChartWidget(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: _currentPage == i
                          ? AppColors.contentColorWhite
                          : AppColors.mainTextColor3,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
