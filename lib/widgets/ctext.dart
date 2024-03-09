import 'package:database/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class cText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final FontStyle? style;
  final TextAlign? align;

  const cText(
      {super.key,
      required this.text,
      this.color = primaryColor,
      this.size,
      this.weight,
      this.style,
      this.align});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size ?? width * 0.039,
        fontWeight: weight,
        fontStyle: style,
      ),
    );
  }
}
