// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '/widgets/grafic.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
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
                    child: Image.asset('assets/images/instagram.png'),
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
                          children: const [
                            Text("Instagram",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            Row(
                              children: [
                                Text("Gasto Total",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(" - 00 MB",
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
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
                  color: Color.fromARGB(255, 247, 247, 247), 
                ),
                margin: EdgeInsets.only(left: 80, right: 200),
                padding: EdgeInsets.only(top: 10, bottom: 30, left: 50, right: 100),
                child: MyLineChart(chartData),
              ),
            )
          ]),
        ));
  }
}
