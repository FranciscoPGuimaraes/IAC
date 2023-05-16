// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '/widgets/switchButton.dart';
//import '/widgets/progressBar.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool ligado = true;

  switch_notification() {
    ligado = !ligado;
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
            Container(
              padding:
                  EdgeInsets.only(top: 50, left: 80, right: 80, bottom: 20),
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
                            Text("Ferramenta de Dados",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 5),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                Container(
                                  height: 100,
                                  width: 650,
                                  margin: EdgeInsets.only(top: 20, left: 5),
                                  child: LinearPercentIndicator(
                                    animation: true,
                                    animationDuration: 3000,
                                    barRadius: const Radius.circular(16),
                                    width: 650,
                                    lineHeight: 25,
                                    percent: 0.8,
                                    center: Text("32GB",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromARGB(
                                              255, 214, 214, 214),
                                        )),
                                    progressColor:
                                        Color.fromARGB(255, 0, 173, 196),
                                    backgroundColor: const Color.fromARGB(
                                        255, 214, 214, 214),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 10),
                                  child: Text("100GB",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 214, 214, 214),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 85),
                                  child: SwitchButton(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 80, left: 10),
                                  child:
                                      Text("Quero ativar a notificação de uso",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: SwitchButton(),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, left: 5),
                                  child: Text("Quero definir um limite diario",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 40, left: 20),
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(
                                                  255, 63, 144, 219)),
                                    ),
                                    onPressed: () => {},
                                    child: Text(
                                        "Mais Créditos",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                        )),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
            SizedBox()
          ]),
        ));
  }
}
