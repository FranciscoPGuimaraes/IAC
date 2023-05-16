import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';

class ChartData {
  final double x;
  final double y;
  ChartData({required this.x, required this.y});
}

List<ChartData> get chartData {
  final data = <double>[25, 100, 50, 200,25 , 75, 50,  150];
  return data
      .mapIndexed(
          ((index, element) => ChartData(x: index.toDouble(), y: element)))
      .toList();
}

class MyLineChart extends StatelessWidget {
  final List<ChartData> points;
  const MyLineChart(this.points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.1,
      child: LineChart(LineChartData(lineBarsData: [
        LineChartBarData(
            barWidth: 2,
            color: Color.fromARGB(255, 152, 189, 94),
            spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
            dotData: FlDotData(show: true)),
      ])),
    );
  }
}