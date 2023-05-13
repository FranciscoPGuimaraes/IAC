import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '/services/SocketConnect.dart';
import '/models/ProcessModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<String> _streamController = StreamController<String>();
  double _pointerValue = 5.0;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect(_streamController);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _changePointerValue(double newValue) {
    setState(() {
      _pointerValue = newValue;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: [1, 2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                            minimum: 0,
                            maximum: 150,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 50,
                                  color: Colors.green),
                              GaugeRange(
                                  startValue: 50,
                                  endValue: 100,
                                  color: Colors.orange),
                              GaugeRange(
                                  startValue: 100,
                                  endValue: 150,
                                  color: Colors.red)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: _pointerValue)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Text(_pointerValue.toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  angle: 90,
                                  positionFactor: 0.5)
                            ])
                      ]);
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              child: StreamBuilder<String>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<Widget> textWidgets = [];
                    var data = snapshot.data;
                    print(data);
                    if (data != null) {
                      Map<String, dynamic> jsonCodeC = jsonDecode(data);
                      for (var element in jsonCodeC.values) {
                        textWidgets.add(Text(
                          '${element["name"]}' + ' ' + '${element["upload"]}',
                          style: const TextStyle(fontSize: 16.0),
                        ));
                      }
                    }
                    return Column(
                      children: textWidgets,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
