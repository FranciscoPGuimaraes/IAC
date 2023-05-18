import 'package:flutter/material.dart';

import '../services/HiveIntegrationNetTest.dart';

List<DataRow> createRows() {
  final crudNet = CrudHiveNet();
  var rowsList = crudNet.getInfo();
  List<DataRow> listWidgets = [];

  for (var element in rowsList) {
    listWidgets.add(DataRow(
      cells: <DataCell>[
        DataCell(Text(
          element[2].replaceAll("_"," - "),
          textAlign: TextAlign.center,
        )),
        DataCell(Text(element[1])),
        DataCell(Text("${element[0].toString().substring(0,8)} MB/s") ),
        DataCell(Text("${element[3].toString().substring(0,8)} MB/s")),
      ],
    ));
  }

  return listWidgets;
}
