
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget gauge_template(double value, double scale, String unit) {
  //print(value);
  return SfRadialGauge(axes: <RadialAxis>[
    RadialAxis(
      minimum: 0,
      maximum: 150 / scale,
      startAngle: 180,
      interval: 30 / scale,
      endAngle: 0,
      axisLineStyle: AxisLineStyle(
        cornerStyle: CornerStyle.bothFlat,
        thickness: scale == 1 ? 100 : 100/2,
        color: Colors.grey,
        gradient: const SweepGradient(colors: <Color>[
          Color.fromRGBO(159, 239, 52, 1),
          Color.fromRGBO(159, 239, 52, 1),
          Color.fromRGBO(254, 196, 73, 1),
          Color.fromRGBO(255, 30, 74, 1),
          Color.fromRGBO(255, 30, 74, 1),
        ], stops: <double>[
          0,
          0.15,
          0.5,
          0.85,
          1
        ]),
      ),
      axisLabelStyle: const GaugeTextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Color.fromRGBO(190, 190, 190, 1),
      ),
      radiusFactor: 0.9,
      showTicks: false,
      showLabels: true,
      showLastLabel: true,
      labelsPosition: ElementsPosition.outside,
      labelOffset: 15,
      pointers: <GaugePointer>[
        NeedlePointer(
          value: value,
          enableAnimation: true,
          needleColor: Colors.white,
          needleStartWidth: 1,
          needleEndWidth: 1,
          lengthUnit: GaugeSizeUnit.factor,
          needleLength: 0.8,
          knobStyle: const KnobStyle(
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
            "${value.toStringAsFixed(4-scale.round())} $unit",
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
    ),
    RadialAxis(
      minimum: 0,
      maximum: 50,
      startAngle: 180,
      endAngle: 0,
      axisLineStyle: AxisLineStyle(
        cornerStyle: CornerStyle.bothFlat,
        thickness: scale == 1 ? 10 : 7,
        color: const Color.fromARGB(255, 237, 237, 237),
      ),
      radiusFactor: scale == 1 ? 0.74 : 0.64,
      showTicks: false,
      showLabels: false,
      showLastLabel: false,
      labelsPosition: ElementsPosition.outside,
      pointers: const <GaugePointer>[
        NeedlePointer(
          needleColor: Colors.white,
          needleLength: 0,
          knobStyle: KnobStyle(
            borderColor: Color.fromRGBO(10, 2, 32, 0),
            color: Color.fromRGBO(10, 2, 32, 0),
          ),
        )
      ],
    ),
  ]);
}
