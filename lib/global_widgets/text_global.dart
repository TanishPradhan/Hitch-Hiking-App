import 'package:flutter/material.dart';

class TextType extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;
  final int maxLines;
  final TextDecoration decoration;

  TextType({
    this.text = "",
    this.color = Colors.black87,
    this.fontsize = 15.0,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w500,
    this.decoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontsize,
          decoration: decoration,
        ),
      ),
    );
  }
}
