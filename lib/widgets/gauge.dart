// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget gauge_template(double value, int scale, String unit) {
  return SfRadialGauge(axes: <RadialAxis>[
    RadialAxis(
      minimum: 0,
      maximum: 150 / scale,
      startAngle: 180,
      endAngle: 0,
      axisLineStyle: AxisLineStyle(
          cornerStyle: CornerStyle.bothFlat,
          thickness: 100 / scale,
          gradient: const SweepGradient(colors: <Color>[
            Color.fromRGBO(159, 239, 52, 1),
            Color.fromRGBO(254, 196, 73, 1),
            Color.fromRGBO(255, 30, 74, 1),
          ], stops: <double>[
            0,
            0.5,
            1
          ]),
          color: Colors.red),
      axisLabelStyle:
          const GaugeTextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      radiusFactor: 0.9,
      showTicks: false,
      showLabels: false,
      pointers: <GaugePointer>[
        NeedlePointer(
          value: value,
          enableAnimation: true,
          needleColor: Colors.white,
          needleStartWidth: 1,
          needleEndWidth: 1,
          lengthUnit: GaugeSizeUnit.factor,
          needleLength: 0.8,
          knobStyle: KnobStyle(
            knobRadius: 0.08,
            sizeUnit: GaugeSizeUnit.factor,
            borderColor: Color.fromRGBO(10, 2, 32, 0),
            color: Color.fromRGBO(10, 2, 32, 0),
            borderWidth: 0.05,
          ),
        )
      ],
      annotations: <GaugeAnnotation>[
        GaugeAnnotation(
          widget: Text(
            "${value.toStringAsFixed(2 + scale - 1)} $unit",
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(190, 190, 190, 1),
            ),
          ),
          angle: 90,
          positionFactor: 0.5,
        )
      ],
    )
  ]);
}
