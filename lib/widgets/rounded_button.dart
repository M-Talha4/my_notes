import 'package:database/utils/colors.dart';
import 'package:database/widgets/ctext.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedButton extends StatelessWidget {
  final String text;
  // final double btnHeight;
  // final double btnWidth;
  final Color? btnColor;
  final Color? borderColor;
  final Color? txtColor;
  final double? txtSize;
  final VoidCallback? callback;

  const RoundedButton({
    super.key,
    required this.text,
    // required this.btnHeight,
    // required this.btnWidth,
    this.btnColor = primaryColor,
    this.borderColor = secondaryColor,
    this.txtColor = primaryColor,
    this.txtSize,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: callback,
      child: Container(
          height: height * 0.045,
          width: width * 0.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor!, width: 1.5),
              color: btnColor,
              borderRadius: BorderRadius.circular(12)),
          child: cText(
            text: text,
            color: txtColor,
            weight: FontWeight.bold,
            align: TextAlign.center,
          )),
    );
  }
}
