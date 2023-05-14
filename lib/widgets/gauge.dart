import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vtable/vtable.dart';

import '../models/ProcessModel.dart';

VTable<ProcessModel> createTable(List<ProcessModel> items) {
  return VTable<ProcessModel>(
    items: items,
    tableDescription: '${items.length} items',
    //startsSorted: true,
    includeCopyToClipboardAction: true,
    columns: [
      VTableColumn(
        label: 'ID',
        width: 180,
        transformFunction: (row) => row.name,
      ),
      VTableColumn(
        label: 'Upload',
        width: 100,
        grow: 1,
        transformFunction: (row) => row.upload,
      ),
    ],
  );
}

Widget gauge_template(double value) {
  return SfRadialGauge(axes: <RadialAxis>[
    RadialAxis(
        minimum: 0,
        maximum: 150,
        axisLineStyle: AxisLineStyle(
          thickness: 20,
          color: Colors.grey[300],
          thicknessUnit: GaugeSizeUnit.logicalPixel,
        ),
        axisLabelStyle:
            const GaugeTextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        radiusFactor: 0.9,
        showTicks: false,
        showLabels: false,
        pointers: <GaugePointer>[
          NeedlePointer(
            value: value,
            enableAnimation: true,
            needleColor: const Color.fromARGB(255, 10, 2, 32),
            needleStartWidth: 1,
            needleEndWidth: 5,
            lengthUnit: GaugeSizeUnit.factor,
            needleLength: 0.7,
            knobStyle: const KnobStyle(
              knobRadius: 0.08,
              sizeUnit: GaugeSizeUnit.factor,
              borderColor: Color.fromARGB(255, 10, 2, 32),
              color: Color.fromARGB(255, 10, 2, 32),
              borderWidth: 0.05,
            ),
          )
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            widget: Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            angle: 90,
            positionFactor: 0.5,
          )
        ],
        ranges: <GaugeRange>[
          GaugeRange(
              startValue: 0,
              endValue: 25,
              color: const Color.fromARGB(255, 77, 140, 235)),
          GaugeRange(
              startValue: 25,
              endValue: 50,
              color: const Color.fromARGB(255, 41, 115, 226)),
          GaugeRange(
              startValue: 50,
              endValue: 75,
              color: const Color.fromARGB(255, 41, 95, 212)),
          GaugeRange(
              startValue: 75,
              endValue: 100,
              color: const Color.fromARGB(255, 26, 87, 218)),
          GaugeRange(
              startValue: 100,
              endValue: 125,
              color: const Color.fromARGB(255, 107, 63, 189)),
          GaugeRange(
              startValue: 125,
              endValue: 150,
              color: const Color.fromARGB(255, 90, 34, 194))
        ])
  ]);
}
