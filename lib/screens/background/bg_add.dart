import 'package:database/screens/background/circle.dart';
import 'package:flutter/material.dart';

class BackgroundAdd extends StatelessWidget {
  final double height;
  final double width;
  const BackgroundAdd({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //   Gradients
      Positioned(
          bottom: height * 0.15,
          right: width * 0.8,
          child: Circle(size: width * 0.3)),
      Positioned(
          top: height * 0.15,
          left: width * 0.75,
          child: Circle(size: width * 0.35)),
    ]);
  }
}
