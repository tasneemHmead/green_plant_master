import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/provider/user_prov.dart';
import 'package:green_plant/screens/auth/login.dart';
import 'package:green_plant/widget/color.dart';
import 'package:green_plant/widget/coustm_text.dart';
import 'package:green_plant/widget/navigater.dart';

import '../control_view.dart';

class RegistrationScreen extends ConsumerWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, watch) {
    final authProvider = watch(userProvider);

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'images/logo.png',
              height: 200,
              width: 200,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        controller: authProvider.name,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            hintText: "Username".tr,
                            icon: Icon(
                              Icons.person,
                              color: primary,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey),
                        cursorColor: Colors.green,
                        controller: authProvider.email,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            hintText: "Email".tr,
                            icon: Icon(
                              Icons.email,
                              color: primary,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey),
                        cursorColor: Colors.green,
                        controller: authProvider.password,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            hintText: "Password".tr,
                            icon: Icon(
                              Icons.lock,
                              color: primary,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");
                        print("BTN CLICKED!!!!");

                        if (!await authProvider.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Resgistration failed!")));
                          return;
                        }

                        authProvider.clearController();
                        changeScreenReplacement(context, ControlView());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "SignUp".tr,
                                color: white,
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeScreen(context, LoginScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: "Login".tr,
                            size: 20,
                            weight: FontWeight.w700,
                            color: white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
