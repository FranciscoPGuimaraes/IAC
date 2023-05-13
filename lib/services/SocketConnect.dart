import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bson/bson.dart';

void connect(StreamController<String> streamController) async {
  try {
    var futures = <Future>[];
    futures.add(handleSocketConnection(50000, streamController));
    //futures.add(handleSocketConnection(50001, streamController));
    //futures.add(handleSocketConnection(50002, streamController));
    await Future.wait(futures);
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> handleSocketConnection(
    int port, StreamController<String> streamController) async {
  try {
    var socket = await Socket.connect('localhost', port);
    //print('Connected to port $port.');

    await for (var data in socket) {
      String receivedData = String.fromCharCodes(data);
      receivedData = receivedData.substring(1);
      receivedData = receivedData.replaceAll("'","");
      
      var json = jsonDecode(receivedData);

      //print('Received from port $port: $receivedData');
      streamController.add(jsonEncode(json));
    }
  } catch (e) {
    print('Error in connection to port $port: $e');
  }
}
