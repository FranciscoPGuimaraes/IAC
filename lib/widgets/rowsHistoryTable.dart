import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;

List<DataRow> createRows() {
  final hiveBox = Hive.box('net_tests');
  List dados = hiveBox.values.toList();
  print(dados[0][1].runtimeType);

  DateFormat formatter = DateFormat('yyyy-MM-dd_HH:mm:ss');
  dados.sort((a, b) {
    DateTime dateA = formatter.parse(a[1]);
    DateTime dateB = formatter.parse(b[1]);
    return dateB.compareTo(dateA); // Inverte a ordem da comparação
  });

  //rowsList.sort((a, b) => a.length.compareTo(b.length));
  List<DataRow> listWidgets = [];

  for (var element in dados) {
    listWidgets.add(DataRow(
      cells: <DataCell>[
        DataCell(Row(children: [
          const SizedBox(width: 20,),
          Text(
          element[1].replaceAll("_", " - "),
          textAlign: TextAlign.center,
        ),
        ],)),
        DataCell(Row(children: [
          const SizedBox(width: 40,),
          Text(element[2])
        ],)),
        DataCell(Row(children: [
          const SizedBox(width: 30,),
          Text("${element[3].toString().substring(0, 6)} MB/s"),
        ],)),
        DataCell(Row(children: [
          const SizedBox(width: 30,),
          Text("${element[0].toString().substring(0, 6)} MB/s")
        ],)),
      ],
    ));
  }

  return listWidgets;
}
