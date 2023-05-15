import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:iac/widgets/gauge.dart';
import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../helpers/converter.dart';
import '../services/HiveIntegration.dart';
import '../widgets/table.dart';
import '/services/SocketConnect.dart';
import '/models/ProcessModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isAscending = true;
  var sortColumnIndex = 0;

  late final CrudHive crud;
  final StreamController<String> _streamController = StreamController<String>();
  double _sumDataValue = 0;
  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  double downloadRate = 0;
  double uploadRate = 0;

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;
  bool sort = false;

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

  saveDataUsed(List<ProcessModel> lista) {
    final double total = lista.fold<double>(
        0,
        (sum, item) =>
            sum + convertToGb(item.upload) + convertToGb(item.download));
    setState(() {
      _sumDataValue = total;
    });
  }

  hiveTest() async {
    await crud.addInfo("Gabriel");
    await crud.getInfo();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect(_streamController);
      crud = CrudHive();
      setBestServers();
    });
  }

  @override
  void dispose() {
    crud.close();
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
                    Column(
                      children: [
                        Builder(
                          builder: (BuildContext context) {
                            return gauge_template(_sumDataValue, 3, "GB");
                          },
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await hiveTest();
                            },
                            child: const Text("Hive"))
                      ],
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
                              return gauge_template(downloadRate, 1, "Mb/s");
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
                                    if (!readyToTest ||
                                        bestServersList.isEmpty) {
                                      return;
                                    }
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
                                return gauge_template(uploadRate, 1, "Mb/s");
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
                                    if (!readyToTest ||
                                        bestServersList.isEmpty) {
                                      return;
                                    }
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
                        padding: const EdgeInsets.only(top: 0),
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
                                    //uploadSpeed: element["upload_speed"],
                                    //downloadSpeed: element["download_speed"],
                                  ));
                                }
                              }
                              Future.delayed(Duration.zero, () {
                                saveDataUsed(textWidgets);
                              });
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
