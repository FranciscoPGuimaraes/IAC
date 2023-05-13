import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

import '/services/SocketConnect.dart';
import '/models/ProcessModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<String> _streamController = StreamController<String>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: [1, 2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width / 2,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(color: Colors.amber),
                          child: Text(
                            'text $i',
                            style: const TextStyle(fontSize: 16.0),
                          ));
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
                    if (data != null) {
                      Map<String, dynamic> jsonCodeC = jsonDecode(data);
                      for (var element in jsonCodeC.values) {
                        textWidgets.add(Text(
                          '${element["name"]}'+'${element["download"]}',
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
