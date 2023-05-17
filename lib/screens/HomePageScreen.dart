import 'dart:async';
import 'dart:convert';

import 'package:ViasatMonitor/widgets/confirmationExit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

import '../helpers/converter.dart';
import '../models/ConfigPageModel.dart';
import '../models/DetailsPageModel.dart';
import '../services/HiveIntegration.dart';
import '../widgets/errorMensagem.dart';
import '../widgets/table.dart';
import '../widgets/gauge.dart';
import '../widgets/initialScreen.dart';
import '../services/SocketConnect.dart';
import '../models/ProcessModel.dart';

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
    double total = lista.fold<double>(
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
    //_streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowClose(context, _streamController);

    final double halfScream = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(40),
              child: SizedBox(
                child: Image.asset("assets/images/viasatlogo.png"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text("Configuração"),
              onTap: () {
                Navigator.of(context).pushNamed('/config',
                    arguments: ConfigScreenArguments(_sumDataValue));
              },
            ),
            ListTile(
              leading: Icon(Icons.pageview),
              title: Text("Detalhes"),
              onTap: () {
                Navigator.of(context).pushNamed('/details',
                    arguments: DetailsScreenArguments(
                        2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        return _ready == 1
            ? FloatingActionButton(
                foregroundColor: Colors.transparent,
                child: Image.asset("assets/images/barra_menu.png"),
                onPressed: () =>
                    Scaffold.of(context).openDrawer(), // <-- Opens drawer.
              )
            : const SizedBox();
      }),
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
                          options: CarouselOptions(height: 1000.0),
                          items: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Dados gastos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Builder(
                                  builder: (BuildContext context) {
                                    return gauge_template(
                                        _sumDataValue, 1, "GB");
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Velocidade de Download:',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Builder(
                                        builder: (BuildContext context) {
                                          return gauge_template(
                                              downloadRate, 1.5, "Mb/s");
                                        },
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 150),
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: readyToTest &&
                                                            !loadingDownload
                                                        ? Color.fromRGBO(
                                                            65, 84, 249, 1)
                                                        : Colors.grey,
                                                  ),
                                                  onPressed: loadingDownload
                                                      ? null
                                                      : () async {
                                                          if (!readyToTest ||
                                                              bestServersList
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                          await _testDownloadSpeed();
                                                        },
                                                  child: const Text('Testar'),
                                                ),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Velocidade de Upload',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Builder(
                                        builder: (BuildContext context) {
                                          return gauge_template(
                                              uploadRate, 1.5, "Mb/s");
                                        },
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 150),
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: readyToTest &&
                                                            !loadingUpload
                                                        ? Color.fromRGBO(
                                                            65, 84, 249, 1)
                                                        : Colors.grey,
                                                  ),
                                                  onPressed: loadingUpload
                                                      ? null
                                                      : () async {
                                                          if (!readyToTest ||
                                                              bestServersList
                                                                  .isEmpty) {
                                                            return;
                                                          }
                                                          await _testUploadSpeed();
                                                        },
                                                  child: const Text('Testar'),
                                                ),
                                        ))
                                  ],
                                ),
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
                        width: halfScream / 1.2,
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
                                    Future.delayed(Duration.zero, () {
                                      saveDataUsed(textWidgets);
                                    });
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
