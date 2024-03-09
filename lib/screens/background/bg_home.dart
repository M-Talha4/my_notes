import 'package:database/screens/background/circle.dart';
import 'package:flutter/material.dart';

class BackgroundHome extends StatelessWidget {
  final double height;
  final double width;
  const BackgroundHome({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //   Gradients
      Positioned(
          top: height * 0.1,
          left: width * 0.48,
          child: Circle(size: width * 0.7)),
      Positioned(
          bottom: height * 0.1,
          right: width * 0.5,
          child: Circle(size: width * 0.6)),
    ]);
  }
}
