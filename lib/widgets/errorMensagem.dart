import 'package:flutter/material.dart';

errorMensage() {
  return Padding(
      padding: const EdgeInsets.all(100),
      child: Column(children: [
        Image.asset(
          'assets/images/error_icon.png',
          height: 100,
          width: 250,
        ),
        const Text(
          textAlign: TextAlign.center,
          "Erro em identificar sua rede, por favor reinicie o aplicativo",
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ]));
}
