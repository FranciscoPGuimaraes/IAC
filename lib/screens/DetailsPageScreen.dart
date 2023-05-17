// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/DetailsPageModel.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool ligado = true;

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(28, 54, 69, 1),
      Color.fromRGBO(28, 54, 69, 1),
    ],
    [
      Color.fromRGBO(0, 136, 193, 1),
      Color.fromRGBO(0, 137, 195, 1),
    ],
    [
      Color.fromRGBO(0, 159, 226, 1),
      Color.fromRGBO(99, 188, 135, 1),
    ],
    [
      Color.fromRGBO(0, 159, 226, 1),
      Color.fromRGBO(99, 188, 135, 1),
    ],
    [
      Color.fromRGBO(139, 200, 98, 1),
      Color.fromRGBO(181, 212, 59, 1),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;
    final double halfScream = MediaQuery.of(context).size.height / 2;

    Map<String, double> dataMapProtocol = {
      "WWW": args.WWW,
      "HTTP": args.HTTP,
      "SSDP": args.SSDP,
      "DOMAIN": args.DOMAIN,
      "HTTPS": args.HTTPS,
      "DNS": args.DNS,
      "others": args.others,
    };

    Map<String, double> dataMapHost = {
      "Host1": 1,
      "Host2": 1,
      "Host3": 2,
      "Host4": 1,
      "Host5": 1,
      "Host6": 1,
      "Host7": 1,
    };

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: 1200,
          height: 700,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            BackButton(
              style: ButtonStyle(),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 80, right: 80, bottom: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/icons/default.png'),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                children: [
                  SizedBox(
                    height: 450,
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Detalhes",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              width: 1000,
                              height: halfScream,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              child: Row(
                                children: [
                                  PieChart(
                                    dataMap: dataMapProtocol,
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: [
                                      Color.fromRGBO(28, 54, 69, 1),
                                      Color.fromRGBO(0, 98, 139, 1),
                                      Color.fromRGBO(0, 137, 195, 1),
                                      Color.fromRGBO(0, 159, 226, 1),
                                      Color.fromRGBO(99, 188, 135, 1),
                                      Color.fromRGBO(139, 200, 98, 1),
                                      Color.fromRGBO(181, 212, 59, 1)
                                    ],
                                    emptyColorGradient: [
                                      Color(0xff6c5ce7),
                                      Colors.blue,
                                    ],
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.disc,
                                    ringStrokeWidth: 32,
                                    centerText: "PROTOCOL",
                                    legendOptions: LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: true,
                                      legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  PieChart(
                                    dataMap: dataMapHost,
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: [
                                      Color.fromRGBO(28, 54, 69, 1),
                                      Color.fromRGBO(0, 98, 139, 1),
                                      Color.fromRGBO(0, 137, 195, 1),
                                      Color.fromRGBO(0, 159, 226, 1),
                                      Color.fromRGBO(99, 188, 135, 1),
                                      Color.fromRGBO(139, 200, 98, 1),
                                      Color.fromRGBO(181, 212, 59, 1)
                                    ],
                                    emptyColorGradient: [
                                      Color(0xff6c5ce7),
                                      Colors.blue,
                                    ],
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.disc,
                                    ringStrokeWidth: 32,
                                    centerText: "HOST",
                                    legendOptions: LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: true,
                                      legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
