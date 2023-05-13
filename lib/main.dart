import 'package:flutter/material.dart';

import 'screens/HomePageScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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