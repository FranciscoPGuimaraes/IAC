import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/adapters.dart';

import '../services/HiveIntegration.dart';

class ChartData {
  final double x;
  final double y;
  ChartData({required this.x, required this.y});
}


List<double> listaa = [];
List<double> searchArray(name){
  late final Box box = Hive.box('history_app');
  
  final regex = RegExp(r'^'+name.replaceAll(".exe", ""));
    List<double> dates = [];

    //print(name);

    for (var element in box.keys) {
      if(regex.hasMatch(element)){
        dates.add(box.get(element)[0]);
      }
    }
    return dates;
}

returnGrafic(nome){
  var lista = searchArray(nome);
    return AspectRatio(
      aspectRatio: 0.1,
      child: LineChart(LineChartData(lineBarsData: [
        LineChartBarData(
            barWidth: 2,
            color: const Color.fromARGB(255, 152, 189, 94),
            spots: lista
                .mapIndexed(((index, element) =>
                    ChartData(x: index.toDouble(), y: element)))
                .toList()
                .map((point) => FlSpot(point.x, point.y))
                .toList(),
            dotData: FlDotData(show: true)),
      ])),
    );
  }
