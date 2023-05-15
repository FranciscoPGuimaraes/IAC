import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget gauge_template(double value, int scale, String unit) {
  return SfRadialGauge(axes: <RadialAxis>[
    RadialAxis(
        minimum: 0,
        maximum: 150/scale,
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
              "${value.toStringAsFixed(2+scale-1)} $unit",
              style: const TextStyle(
                fontSize: 18,
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
              endValue: 25/scale,
              color: const Color.fromARGB(255, 77, 140, 235)),
          GaugeRange(
              startValue: 25/scale,
              endValue: 50/scale,
              color: const Color.fromARGB(255, 41, 115, 226)),
          GaugeRange(
              startValue: 50/scale,
              endValue: 75/scale,
              color: const Color.fromARGB(255, 41, 95, 212)),
          GaugeRange(
              startValue: 75/scale,
              endValue: 100/scale,
              color: const Color.fromARGB(255, 26, 87, 218)),
          GaugeRange(
              startValue: 100/scale,
              endValue: 125/scale,
              color: const Color.fromARGB(255, 107, 63, 189)),
          GaugeRange(
              startValue: 125/scale,
              endValue: 150/scale,
              color: const Color.fromARGB(255, 90, 34, 194))
        ])
  ]);
}
