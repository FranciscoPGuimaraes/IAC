import 'package:ViasatMonitor/models/ProtocolChartModel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

Widget createChart(String title, Map<String, double> dataMapProtocol, double chartRadius) {
  return PieChart(
    dataMap: dataMapProtocol,
    animationDuration: const Duration(milliseconds: 800),
    chartLegendSpacing: 32,
    chartRadius: chartRadius,
    colorList: const [
      Color.fromRGBO(28, 54, 69, 1),
      Color.fromRGBO(0, 98, 139, 1),
      Color.fromRGBO(0, 137, 195, 1),
      Color.fromRGBO(0, 159, 226, 1),
      Color.fromRGBO(99, 188, 135, 1),
      Color.fromRGBO(139, 200, 98, 1),
      Color.fromRGBO(181, 212, 59, 1)
    ],
    emptyColorGradient: const [
      Color(0xff6c5ce7),
      Colors.blue,
    ],
    initialAngleInDegree: 0,
    chartType: ChartType.disc,
    ringStrokeWidth: 16,
    centerText: title,
    legendOptions: const LegendOptions(
      showLegendsInRow: false,
      legendPosition: LegendPosition.right,
      showLegends: true,
      legendTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    chartValuesOptions: const ChartValuesOptions(
      showChartValueBackground: true,
      showChartValues: true,
      showChartValuesInPercentage: true,
      showChartValuesOutside: false,
      decimalPlaces: 4,
    ),
  );
}
