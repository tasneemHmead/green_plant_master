import 'package:flutter/material.dart';
import 'package:green_plant/helper/constance.dart';

import '../custom_text.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPress;
  final Color backgroundColor;
  final Color textColor;
  final Alignment alignment;
  final double fontSize;

  CustomButtonWithIcon({
    @required this.text,
    @required this.imageName,
    @required this.onPress,
    @required this.backgroundColor,
    this.textColor = Colors.white,
    this.alignment = Alignment.center,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(25.0),
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(.5),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        child: ListTile(
          title: CustomText(
            alignment: alignment,
            fontSize: fontSize,
            text: text,
            color: textColor,
          ),
          leading: Image.asset(imageName),
        ),
      ),
    );
  }
}
