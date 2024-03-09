import 'package:database/utils/colors.dart';
import 'package:database/widgets/ctext.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class cTextField extends StatefulWidget {
  final String label;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final bool obsucreText;
  final int? maxLines;
  final void Function(String)? callback;

  const cTextField({
    super.key,
    required this.label,
    required this.textController,
    this.keyboardType,
    this.maxLines = 1,
    this.obsucreText = false,
    this.callback,
  });

  @override
  State<cTextField> createState() => _cTextFieldState();
}

// ignore: camel_case_types
class _cTextFieldState extends State<cTextField> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return TextFormField(
      controller: widget.textController,
      keyboardType: widget.keyboardType,
      obscureText: widget.obsucreText,
      obscuringCharacter: '*',
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        label: cText(
          text: widget.label,
          color: primaryColor,
          size: width * 0.042,
        ),
        alignLabelWithHint: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.015),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(4)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onChanged: widget.callback,
    );
  }
}
