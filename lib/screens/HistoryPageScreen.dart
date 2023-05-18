// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import '../services/SocketConnect.dart';
import '../widgets/rowsHistoryTable.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final StreamController<String> _streamController = StreamController<String>();
  bool ligado = true;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect2(_streamController);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    final double halfScream = MediaQuery.of(context).size.height / 2;

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
                            Text("Historico",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 100),
                              margin: EdgeInsets.only(top: 30),
                              width: 1000,
                              height: halfScream,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 800,
                                    child: DataTable(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 189, 230, 123),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 152, 189, 94),
                                              width: 2)),
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Expanded(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Column(children: [
                                                    Text(
                                                      'Data/Hora',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ]))),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Column(children: [
                                                    Text(
                                                      'Ping',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Text(
                                                      'ms',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ]))),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Column(children: [
                                                    Text(
                                                      'Download',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Mbps',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ]))),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Column(children: [
                                                    Text(
                                                      'Upload',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Mbps',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ]))),
                                        ),
                                      ],
                                      rows: createRows()
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
