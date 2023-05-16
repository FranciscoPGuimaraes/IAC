
import 'package:flutter/material.dart';
import 'package:vtable_package/vtable.dart';


import '../models/ProcessModel.dart';
import '../helpers/converter.dart';

VTable<ProcessModel> createTable(List<ProcessModel> items) {
  return VTable<ProcessModel>(
    //supportsSelection: true,
    items: items,
    //tableDescription: '${items.length} items',
    startsSorted: true,
    columns: [
      VTableColumn(
        label: 'Processo',
        width: 100,
        grow: 0.5,
        transformFunction: (row) => row.name,
        compareFunction: (a, b) => sumAndConvertToMb(b.download, b.upload).compareTo(sumAndConvertToMb(a.download, a.upload)),
      ),
      VTableColumn(
        label: 'Gasto',
        width: 100,
        grow: 1,
        transformFunction: (row) => "${(sumAndConvertToMb(row.download, row.upload)).toStringAsFixed(4).substring(0,6)} MB",
        compareFunction: (a, b) => sumAndConvertToMb(b.download, b.upload).compareTo(sumAndConvertToMb(a.download, a.upload)),
      ),
      VTableColumn(
        label: 'Estado',
        width: 100,
        grow: 1,
        transformFunction: (row) => "${(sumAndConvertToMb(row.download, row.upload)).toStringAsFixed(4).substring(0,6)} ",
        compareFunction: (a, b) => sumAndConvertToMb(b.download, b.upload).compareTo(sumAndConvertToMb(a.download, a.upload)),
        renderFunction: (context, data, string) {
          final total = sumAndConvertToMb(items[1].upload, items[1].download);
          final media = items.fold<double>(0, (sum, item) => sum + sumAndConvertToMb(item.download, item.upload))/items.length;
          if(sumAndConvertToMb(data.upload, data.download) > total){
            return const Chip(
              label: SizedBox(width: 100, height: 5),
              labelPadding: EdgeInsets.all(-2),
              backgroundColor: Colors.red,
            );
          } else if (sumAndConvertToMb(data.upload, data.download) > media) {
            return const Chip(
              label: SizedBox(width: 100, height: 5),
              labelPadding: EdgeInsets.all(-2),
              backgroundColor: Colors.yellow,
            );
          }
           else {
            return const Chip(
              label: SizedBox(width: 100, height: 5),
              labelPadding: EdgeInsets.all(-2),
              backgroundColor: Colors.blue,
            );
          }
        },
      ),
    ],
  );
}