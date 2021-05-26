import 'package:flutter/material.dart';
import 'package:green_plant/screens/auth/login.dart';
import 'package:green_plant/widget/navigater.dart';
import 'package:green_plant/widget/original_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            Image.asset(
              'images/logo.png',
              // fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OriginalButton(
                text: 'Get Started',
                color: Colors.white,
                textColor: Colors.green,
                onPressed: () {
                  changeScreenReplacement(context, LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
