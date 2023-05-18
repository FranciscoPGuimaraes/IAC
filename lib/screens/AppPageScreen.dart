// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vtable_package/vtable.dart';
import '../helpers/converter.dart';
import '../models/AppPageModel.dart';
import '/widgets/grafic.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    final argsT = ModalRoute.of(context)!.settings.arguments;
    final args = AppScreenArguments.toAppScreenArguments(argsT);

    final double halfScream = MediaQuery.of(context).size.height / 2;
    return Scaffold(
        extendBody: true,
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
                    child:
                        Image.asset('assets/icons/' + findConstant(args.name)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 152, 189, 94),
                            width: 2)),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    margin: EdgeInsets.only(
                        top: 0, left: 775, right: 0, bottom: 40),
                    child: Text("HTTP",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        )),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(args.name.replaceAll(".exe", ""),
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 152, 189, 94),
                                            width: 2)),
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    child: Row(
                                      children: [
                                        Text("Gasto Total",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(
                                            " - ${(sumAndConvertToMb(args.dowload, args.upload)).toStringAsFixed(2)} MB",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 152, 189, 94),
                                            width: 2)),
                                    margin: EdgeInsets.only(top: 10, left: 65),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text("Upload",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(
                                            " - ${convertToMb(args.upload).toStringAsFixed(0)} MB",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 152, 189, 94),
                                            width: 2)),
                                    margin: EdgeInsets.only(top: 10, left: 65),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 5),
                                    child: Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text("Download",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        Text(
                                            " - ${convertToMb(args.dowload).toStringAsFixed(0)} MB",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    ))
                              ],
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 1200,
              height: 350,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                margin: EdgeInsets.only(top: 30, left: 60, right: 80),
                padding:
                    EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
                child: MyLineChart(chartData),
              ),
            )
          ]),
        ));
  }
}
