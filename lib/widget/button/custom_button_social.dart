import 'package:flutter/material.dart';

import '../custom_text.dart';

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPress;
  final Color backgroundColor;

  CustomButtonSocial({
    @required this.text,
    @required this.imageName,
    @required this.onPress,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: backgroundColor,
      ),
      child: FlatButton(
        onPressed: onPress,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageName),
            SizedBox(
              width: 20,
            ),
            CustomText(
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}
