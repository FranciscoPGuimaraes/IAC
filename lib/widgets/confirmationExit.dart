
import 'package:flutter/material.dart';
import 'package:flutter_window_close/flutter_window_close.dart';

windowClose(context, _streamController){
return FlutterWindowClose.setWindowShouldCloseHandler(() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
          title: //const Text('Realmente deseja fechar o app e deixar de monitorar sua rede?'),
          const Column(children: [
            Text('Realmente deseja fechar o app?'),
            Text('Você deixará de monitorar sua rede...',
            style: TextStyle(fontSize: 14),),
          ]),
          actions: [
            ElevatedButton(
            onPressed: () => { 
              _streamController.close(),
              Navigator.of(context).pop(true)
            },
            child: const Text('Sim')),
            ElevatedButton(
            onPressed: () {Navigator.of(context).pop(false);},
            child: const Text('Não')),
          ]);
        });
});
}