import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:iac/widgets/gauge.dart';
import 'package:flutter/material.dart';
import 'package:iac/widgets/initialScreen.dart';
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

import '../helpers/converter.dart';
import '../services/HiveIntegration.dart';
import '../widgets/errorMensagem.dart';
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

  CarouselController carouselController = CarouselController();

  late final CrudHive crud;
  final StreamController<String> _streamController = StreamController<String>();
  int _ready = 0;
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

  runTimer() {
    Timer(
      const Duration(seconds: 4),
      () {
        setState(() {
          _ready = 1;
        });
      },
    );
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect(_streamController);
      crud = CrudHive();
      setBestServers();
      runTimer();
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
      body: _ready == 0
          ? allInitialScreen()
          : Container(
              width: 1200,
              height: 700,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: halfScream / 1.15,
                    child: Stack(children: [
                      CarouselSlider(
                          carouselController: carouselController,
                          options: CarouselOptions(height: 800.0),
                          items: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Builder(
                                  builder: (BuildContext context) {
                                    return gauge_template(
                                        _sumDataValue, 1, "GB");
                                  },
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  height: 5,
                                ),
                                Stack(children: [
                                  SizedBox(
                                        height: 200,
                                        child: Builder(
                                          builder: (BuildContext context) {
                                            return gauge_template(
                                                downloadRate, 2, "Mb/s");
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 150),
                                      child: loadingDownload
                                        ? const Column(
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : ElevatedButton(
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
                                          child: const Text('Testar'),
                                        ),
                                      ))
                                ],),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Upload Test:',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                
                                Stack(children: [
                                  SizedBox(
                                        height: 200,
                                        child: Builder(
                                          builder: (BuildContext context) {
                                            return gauge_template(
                                                uploadRate, 2, "Mb/s");
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 150),
                                      child: loadingUpload
                                        ? const Column(
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: readyToTest && !loadingUpload
                                                ? Colors.blue
                                                : Colors.grey,
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
                                          child: const Text('Testar'),
                                        ),
                                      ))
                                ],),
                              ],
                            ),
                          ]),
                      Padding(
                          padding: const EdgeInsets.only(top: 40, left: 80),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              color: const Color.fromRGBO(135, 135, 135, 1),
                              onPressed: () {
                                carouselController.previousPage();
                              },
                              icon: const Icon(Icons.navigate_before),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 40, right: 80),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              color: const Color.fromRGBO(135, 135, 135, 1),
                              onPressed: () {
                                carouselController.nextPage();
                              },
                              icon: const Icon(Icons.navigate_next),
                            ),
                          )),
                    ]),
                  ),
                  Center(
                    child: SizedBox(
                        width: halfScream / 1.3,
                        child: DecoratedBox(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: StreamBuilder<String>(
                                stream: _streamController.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.connectionState ==
                                          ConnectionState.active) {
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
                                    //print(textWidgets);
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 100, bottom: 100),
                                        child: createTable(textWidgets));
                                  } else {
                                    return errorMensage();
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
