import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final int percent;
  final LinearGradient gradient;
  final Color backgroundColor;

  const GradientProgressBar(
      {required this.percent,
      required this.gradient,
      required this.backgroundColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: percent,
          fit: FlexFit.tight,
          child: Container(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: percent == 100
                  ? const BorderRadius.all(Radius.circular(10))
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
            ),
            child: const SizedBox(height: 20),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 100 - percent,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: percent == 0
                  ? const BorderRadius.all(Radius.circular(10))
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
            ),
            child: const SizedBox(height: 20),
          ),
        ),
      ],
    );
  }
}