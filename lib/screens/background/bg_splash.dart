import 'package:database/screens/background/circle.dart';
import 'package:flutter/material.dart';

class BackgroundSplash extends StatelessWidget {
  final double height;
  final double width;
  const BackgroundSplash(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //   Gradients
      Positioned(
          bottom: height * 0.9,
          left: width * 0.22,
          child: Circle(size: width * 0.2)),
      Positioned(
          top: width * 0.15,
          left: width * 0.8,
          child: Circle(size: width * 0.25)),
      Positioned(
          top: width * 0.25,
          right: width * 0.85,
          child: Circle(size: width * 0.22)),
      Positioned(
          top: width * 0.45,
          left: width * 0.35,
          child: Circle(size: width * 0.17)),
      Positioned(
          top: width * 0.7,
          left: width * 0.06,
          child: Circle(size: width * 0.15)),
      Positioned(
          top: width * 0.7,
          right: width * 0.11,
          child: Circle(size: width * 0.2)),
      Positioned(
          top: width, left: width * 0.13, child: Circle(size: width * 0.23)),
      Positioned(
          top: width * 1.1,
          left: width * 0.8,
          child: Circle(size: width * 0.27)),
    ]);
  }
}
