import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ViasatMonitor/helpers/getSystemInfo.dart';
import 'package:ViasatMonitor/widgets/confirmationExit.dart';
import 'package:hive/hive.dart';
import  'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

import '../helpers/converter.dart';
import '../models/ConfigPageModel.dart';
import '../services/HiveIntegration.dart';
import '../services/HiveIntegrationNetTest.dart';
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

  int textPing = -1;

  CarouselController carouselController = CarouselController();

  late final CrudHive crud;
  late final CrudHiveNet crudNet;
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
      loadingUpload = true;
    });
    final _downloadRate =
        await tester.testDownloadSpeed(servers: bestServersList);
    setState(() {
      downloadRate = _downloadRate;
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

  //void startRepeatedExecution() {
  //  const duration = Duration(seconds: 15);
  //  Timer.periodic(duration, (Timer timer) {
  //    // Chame a função que deseja executar a cada 10 minutos aqui
  //    executeFunction();
  //  });
  //}

  //void executeFunction() async {
  //  String tdata = DateFormat("yyyy-MM-dd_HH-mm").format(DateTime.now());
  //  print(tdata);
  //  //await crud.addInfoSummed(tdata, _sumDataValue);
  //  await crud.getInfo();
  //}

  _saveNetTest(upload,download,ping,date) async{
    await crudNet.addInfoNetTest(upload,download,ping,getDate());
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

  getHostIp(){
    final hostname = 'google.com';

    InternetAddress.lookup(hostname).then((List<InternetAddress> addresses) {
      if (addresses.isNotEmpty) {
        final address = addresses.first;
        print('Endereço IP: ${address.address}');
        return address.address;
      } else {
        print('Não foi possível resolver o nome de host.');
      }
    }).catchError((error) {
      print('Ocorreu um erro ao resolver o nome de host: $error');
    });
    return "142.251.128.110";
  }

  Future<void> measureLatency() async {
    final address = InternetAddress(getHostIp()); // Substitua pelo endereço que deseja medir a latência
    final port = 80; // Substitua pela porta que deseja usar

    final socket = await Socket.connect(address, port);

    final startTime = DateTime.now();

    socket.write(
        'GET / HTTP/1.1\r\nHost: exemplo.com\r\nConnection: close\r\n\r\n');

    await socket.flush();
    await socket.close();

    final endTime = DateTime.now();

    final latency = endTime.difference(startTime).inMilliseconds;

    setState(() {
      textPing = latency;
    });
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connect(_streamController);
      crud = CrudHive();
      crudNet = CrudHiveNet();
      setBestServers();
      runTimer();
      //startRepeatedExecution();
    });
  }

  @override
  void dispose() {
    crud.close();
    crudNet.close();
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
              padding: const EdgeInsets.all(40),
              child: SizedBox(
                child: Image.asset("assets/images/viasatlogo.png"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text("Configuração"),
              onTap: () {
                Navigator.of(context).pushNamed('/config',
                    arguments: ConfigScreenArguments(_sumDataValue));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pageview),
              title: const Text("Detalhes"),
              onTap: () {
                Navigator.of(context).pushNamed('/details');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Histórico"),
              onTap: () {
                Navigator.of(context).pushNamed('/history');
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
                                  ],
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
                                                    backgroundColor: readyToTest &&
                                                            !loadingUpload
                                                        ? const Color.fromRGBO(
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
                                                          await _testDownloadSpeed();
                                                          await _testUploadSpeed();//upload,download,ping,date
                                                          await _saveNetTest(
                                                            "$uploadRate MB/s",
                                                            "$downloadRate MB/s",
                                                            "$textPing ms",
                                                            getDate()
                                                          );
                                                        },
                                                  child: const Text('Testar'),
                                                ),
                                        )),
                                  ],
                                ),
                                textPing > -1
                                    ? Text(
                                        "Ping: $textPing ms",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    : const SizedBox()
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
                                      ));
                                    }
                                  }
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
                          ),
                        )),
                  ),
                ],
              ),
            ),
    );
  }
}
