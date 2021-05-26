import 'package:flutter/material.dart';
import 'package:green_plant/helper/constance.dart';

import '../custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String textFamily;

  final Color color;
  final Color textColor;
  final Function onPress;

  CustomButton({
    @required this.onPress,
    this.textFamily,
    this.text = 'Write text ',
    this.color = primaryColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(10),
        onPressed: onPress as void Function(),
        color: color,
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          color: textColor,
          family: "",
        ),
      ),
    );
  }
}
