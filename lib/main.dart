import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'screens/HomePageScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1200, 700));
    WindowManager.instance.setMaximumSize(const Size(1200, 700));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "teste",
      initialRoute: '/',//onde vai comecar o app
      routes: {
        '/': (context) => const HomePage(),
      },
      //},
    );
  } // Build
} // Stateless
