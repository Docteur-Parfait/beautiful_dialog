// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional import for platform-specific export functionality
import 'provider/web_export_provider.dart'
    if (dart.library.html) 'provider/web_export_provider.dart' as webExport;
import 'provider/mobile_export_provider.dart'
    if (dart.library.io) 'provider/mobile_export_provider.dart' as mobileExport;

class DataVisualizationDialog {
  static void showDataVisualizationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: const DataVisualizationContent(),
          ),
        );
      },
    );
  }
}

class DataVisualizationContent extends StatefulWidget {
  const DataVisualizationContent({super.key});

  @override
  State<DataVisualizationContent> createState() =>
      _DataVisualizationContentState();
}

enum ChartType { line, bar, scatter, radar, pie }

class _DataVisualizationContentState extends State<DataVisualizationContent> {
  bool isLineChart = true;
  bool showAvg = false;

  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  ChartType currentChart = ChartType.line;
  final GlobalKey _chartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Data Visualization",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Expanded(
            child: RepaintBoundary(
              key: _chartKey,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.blue.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    _buildCurrentChart(),
                    if (currentChart == ChartType.line)
                      Positioned(
                        right: 20,
                        top: 20,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showAvg = !showAvg;
                            });
                          },
                          child: Text(
                            'AVG',
                            style: TextStyle(
                              fontSize: 12,
                              color: showAvg
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          _buildChartControls(),
        ],
      ),
    );
  }

  Widget _buildCurrentChart() {
    switch (currentChart) {
      case ChartType.line:
        return LineChart(
          showAvg ? avgData() : mainData(),
        );
      case ChartType.bar:
        return BarChart(getBarChartData());
      case ChartType.scatter:
        return ScatterChart(getScatterChartData());
      case ChartType.radar:
        return RadarChart(getRadarChartData());
      case ChartType.pie:
        return PieChart(getPieChartData());
    }
  }

  Widget _buildChartControls() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildChartButton('Line', ChartType.line, Colors.blue),
              _buildChartButton('Bar', ChartType.bar, Colors.green),
              _buildChartButton('Scatter', ChartType.scatter, Colors.orange),
              _buildChartButton('Radar', ChartType.radar, Colors.purple),
              _buildChartButton('Pie', ChartType.pie, Colors.red),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.save, color: Colors.white),
                label:
                    const Text("Export", style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: _exportChart,
              ),
              TextButton.icon(
                icon: const Icon(Icons.close, color: Colors.white),
                label:
                    const Text("Close", style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartButton(String label, ChartType type, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: currentChart == type ? color : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: () => setState(() => currentChart = type),
      child: Text(label),
    );
  }

  Future<void> _exportChart() async {
    try {
      final RenderRepaintBoundary boundary =
          _chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();
        if (kIsWeb) {
          // Use web export functionality
          await webExport.exportBytes(
            bytes: pngBytes,
            fileName: 'chart_${DateTime.now().millisecondsSinceEpoch}.png',
            mimeType: 'image/png',
          );
        } else {
          // Use mobile export functionality
          await mobileExport.exportBytes(
            bytes: pngBytes,
            fileName: 'chart_${DateTime.now().millisecondsSinceEpoch}.png',
            mimeType: 'image/png',
          );
        }

        // Show success message using bot_toast
        BotToast.showText(
          text: 'Chart exported successfully!',
          duration: const Duration(seconds: 2),
          contentColor: Colors.green,
        );
      }
    } catch (e) {
      // Show error message using bot_toast
      BotToast.showText(
        text: 'Failed to export chart',
        duration: const Duration(seconds: 2),
        contentColor: Colors.red,
      );
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              return LineTooltipItem(
                touchedSpot.y.toStringAsFixed(1),
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarChartData getBarChartData() {
    return BarChartData(
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: 3, gradient: _barsGradient),
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: 2, gradient: _barsGradient),
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: 5, gradient: _barsGradient),
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: 3.1, gradient: _barsGradient),
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(toY: 4, gradient: _barsGradient),
          ],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(toY: 3, gradient: _barsGradient),
          ],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(toY: 4, gradient: _barsGradient),
          ],
        ),
      ],
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitleWidgets,
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(1),
              const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  LinearGradient get _barsGradient => LinearGradient(
        colors: gradientColors,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  ScatterChartData getScatterChartData() {
    return ScatterChartData(
      scatterSpots: [
        ScatterSpot(4, 4),
        ScatterSpot(2, 5),
        ScatterSpot(4, 5),
        ScatterSpot(8, 6),
        ScatterSpot(5, 7),
        ScatterSpot(7, 2),
        ScatterSpot(3, 2),
        ScatterSpot(2, 1),
      ],
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: true),
    );
  }

  RadarChartData getRadarChartData() {
    return RadarChartData(
      radarShape: RadarShape.circle,
      dataSets: [
        RadarDataSet(
          fillColor: Colors.blue.withOpacity(0.2),
          borderColor: Colors.blue,
          entryRadius: 2,
          dataEntries: [
            const RadarEntry(value: 100),
            const RadarEntry(value: 80),
            const RadarEntry(value: 60),
            const RadarEntry(value: 70),
            const RadarEntry(value: 90),
            const RadarEntry(value: 75),
          ],
        ),
      ],
      ticksTextStyle: const TextStyle(color: Colors.black, fontSize: 10),
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
      radarBorderData: BorderSide(color: Colors.grey.withOpacity(0.2)),
      titlePositionPercentageOffset: 0.2,
      getTitle: (index, value) {
        // Update the parameters to accept both index and value
        switch (index) {
          case 0:
            return const RadarChartTitle(text: 'Sales');
          case 1:
            return const RadarChartTitle(text: 'Marketing');
          case 2:
            return const RadarChartTitle(text: 'Dev');
          case 3:
            return const RadarChartTitle(text: 'Design');
          case 4:
            return const RadarChartTitle(text: 'Support');
          case 5:
            return const RadarChartTitle(text: 'Tech');
          default:
            return const RadarChartTitle(text: '');
        }
      },
    );
  }

  PieChartData getPieChartData() {
    return PieChartData(
      sections: [
        PieChartSectionData(
          value: 35,
          color: Colors.blue,
          title: '35%',
          radius: 50,
          titleStyle: const TextStyle(color: Colors.white),
        ),
        PieChartSectionData(
          value: 25,
          color: Colors.green,
          title: '25%',
          radius: 50,
          titleStyle: const TextStyle(color: Colors.white),
        ),
        PieChartSectionData(
          value: 20,
          color: Colors.orange,
          title: '20%',
          radius: 50,
          titleStyle: const TextStyle(color: Colors.white),
        ),
        PieChartSectionData(
          value: 20,
          color: Colors.purple,
          title: '20%',
          radius: 50,
          titleStyle: const TextStyle(color: Colors.white),
        ),
      ],
      sectionsSpace: 2,
      centerSpaceRadius: 40,
    );
  }
}
