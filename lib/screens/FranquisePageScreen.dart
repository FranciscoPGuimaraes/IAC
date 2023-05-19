// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import '../models/ConfigPageModel.dart';
import '../services/SocketConnect.dart';
import '../widgets/rowsHistoryTable.dart';
import '../services/HiveIntegrationPlano.dart';

class FranquisePage extends StatefulWidget {
  const FranquisePage({super.key});

  @override
  State<FranquisePage> createState() => _FranquisePageState();
}

class _FranquisePageState extends State<FranquisePage> {
  bool ligado = true;
  late CrudHivePlano crud;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      crud = CrudHivePlano();
    });
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
                    child: Image.asset('assets/images/plano.png'),
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
                            Text("Meu Plano",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.only(top: 30),
                              height: halfScream,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(0, 0, 0, 0)),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Row(children: [
                                      InkWell(
                                        onTap: () {
                                          crud.addInfo(25);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Plano trocado para Econômico, confira na aba configuração!"),
                                          ));
                                        },
                                        child: Container(
                                          width: 230,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 162, 224, 61),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Text("ECONÔMICO",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 12, 27, 39),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text("Como aproveitar seu",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 12, 27, 39),
                                                  )),
                                            ),
                                            Text("plano?",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 12, 27, 39),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Franquia",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("Mensal",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("até 25",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Noite Livre",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("300",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Velocidade",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 40),
                                                  Column(
                                                    children: [
                                                      Text("10 MEGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          crud.addInfo(50);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Plano trocado para Smart, confira na aba configuração!"),
                                          ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          width: 230,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 41, 172, 182),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Text("SMART",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 12, 27, 39),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text("Como aproveitar seu",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 12, 27, 39),
                                                  )),
                                            ),
                                            Text("plano?",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 12, 27, 39),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Franquia",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("Mensal",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("até 50",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Noite Livre",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("400",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Velocidade",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 40),
                                                  Column(
                                                    children: [
                                                      Text("15 MEGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          crud.addInfo(100);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Plano trocado para Prime, confira na aba configuração!"),
                                          ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          width: 230,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 41, 119, 182),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Text("PRIME",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 12, 27, 39),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text("Como aproveitar seu",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 12, 27, 39),
                                                  )),
                                            ),
                                            Text("plano?",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 12, 27, 39),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Franquia",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("Mensal",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("até 100",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Noite Livre",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("500",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Velocidade",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 40),
                                                  Column(
                                                    children: [
                                                      Text("20 MEGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    12,
                                                                    27,
                                                                    39),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          crud.addInfo(160);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Plano trocado para Infinity, confira na aba configuração!"),
                                          ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          width: 230,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 12, 27, 39),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Text("INFINITY",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 162, 224, 61),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text("Como aproveitar seu",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 162, 224, 61),
                                                  )),
                                            ),
                                            Text("plano?",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 162, 224, 61),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Franquia",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                      Text("Mensal",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 60),
                                                  Column(
                                                    children: [
                                                      Text("até 160",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                      Text("GIGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Noite Livre",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 30),
                                                  Column(
                                                    children: [
                                                      Text("ILIMITADO",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15, left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Velocidade",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(width: 40),
                                                  Column(
                                                    children: [
                                                      Text("30 MEGA",
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    162,
                                                                    224,
                                                                    61),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ]),
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
