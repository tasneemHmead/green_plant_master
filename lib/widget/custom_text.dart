import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String family;

  final double fontSize;

  final Color color;

  final Alignment alignment;

  final int maxLine;
  final double height;
  final FontWeight fontWeight;

  CustomText({
    @required this.text,
    this.family = 'Nexa',
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLine,
    this.height = 1,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: height,
          fontFamily: family,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
        maxLines: maxLine,
      ),
    );
  }
}
