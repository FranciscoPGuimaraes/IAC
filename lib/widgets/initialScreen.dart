import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

allInitialScreen() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/viasatlogo.png',
              height: 100,
              width: 250,
            ),
            GradientText(
              "Monitor",
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
              colors: const [
                Color.fromRGBO(22, 50, 67, 1),
                Color.fromRGBO(0, 141, 201, 1),
                Color.fromRGBO(109, 192, 127, 1),
                Color.fromRGBO(189, 215, 50, 1),
              ],
            ),
          ],
        ),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    ),
  );
}
