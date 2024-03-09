import 'package:flutter/material.dart';
import '../../utils/colors.dart';

// ignore: must_be_immutable
class Circle extends StatelessWidget {
  double size;
  String? image;

  Circle({super.key, required this.size, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          image: image != null
              ? DecorationImage(image: AssetImage(image!), fit: BoxFit.cover)
              : null,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                secondaryColor.withOpacity(0.7),
                primaryColor.withOpacity(0.8)
              ]),
        ));
  }
}
