import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:iac/widgets/gauge.dart';
import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';
import 'package:vtable/vtable.dart';

import '/services/SocketConnect.dart';
import '/models/ProcessModel.dart';
import '/widgets/gauge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<String> _streamController = StreamController<String>();
  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  double downloadRate = 0;
  double uploadRate = 0;

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;

  Future<void> setBestServers() async {
    final settings = await tester.getSettings();
    final servers = settings.servers;

    final _bestServersList = await tester.getBestServers(
      servers: servers,
    );

    setState(() {
      bestServersList = _bestServersList;
      readyToTest = true;
    });
  }

  Future<void> _testDownloadSpeed() async {
    setState(() {
      loadingDownload = true;
    });
    final _downloadRate =
        await tester.testDownloadSpeed(servers: bestServersList);
    setState(() {
      downloadRate = _downloadRate;
      loadingDownload = false;
    });
  }

  Future<void> _testUploadSpeed() async {
    setState(() {
      loadingUpload = true;
    });

    final _uploadRate = await tester.testUploadSpeed(servers: bestServersList);

    setState(() {
      uploadRate = _uploadRate;
      loadingUpload = false;
    });
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect(_streamController);
      setBestServers();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double halfScream = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: CarouselSlider(
                  options: CarouselOptions(height: 800.0),
                  items: [
                    Builder(
                      builder: (BuildContext context) {
                        return gauge_template(50);
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Download Test:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 200,
                          child: Builder(
                            builder: (BuildContext context) {
                              return gauge_template(downloadRate);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (loadingDownload)
                          const Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: readyToTest && !loadingDownload
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            onPressed: loadingDownload
                                ? null
                                : () async {
                                    if (!readyToTest || bestServersList.isEmpty)
                                      return;
                                    await _testDownloadSpeed();
                                  },
                            child: const Text('Start'),
                          ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Upload Test:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 200,
                            child: Builder(
                              builder: (BuildContext context) {
                                return gauge_template(uploadRate);
                              },
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        if (loadingUpload)
                          const Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: readyToTest ? Colors.blue : Colors.grey,
                            ),
                            onPressed: loadingUpload
                                ? null
                                : () async {
                                    if (!readyToTest || bestServersList.isEmpty)
                                      return;
                                    await _testUploadSpeed();
                                  },
                            child: const Text('Start'),
                          ),
                      ],
                    ),
                  ]),
            ),
            Center(
              child: SizedBox(
                  width: halfScream,
                  child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: StreamBuilder<String>(
                          stream: _streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              List<ProcessModel> textWidgets = [];
                              var data = snapshot.data;
                              if (data != null) {
                                Map<String, dynamic> jsonCodeC =
                                    jsonDecode(data);
                                for (var element in jsonCodeC.values) {
                                  textWidgets.add(ProcessModel(
                                    name: element["name"],
                                    upload: element["upload"],
                                    download: element["download"],
                                    uploadSpeed: element["upload_speed"],
                                    downloadSpeed: element["download_speed"],
                                  ));
                                }
                              }
                              return createTable(textWidgets);
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
