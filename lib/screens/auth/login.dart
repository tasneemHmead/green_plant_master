import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/provider/user_prov.dart';
import 'package:green_plant/screens/auth/signup.dart';
import 'package:green_plant/screens/control_view.dart';
import 'package:green_plant/widget/color.dart';
import 'package:green_plant/widget/coustm_text.dart';
import 'package:green_plant/widget/navigater.dart';

class LoginScreen extends ConsumerWidget {
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
          children: [
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: thirdColor,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              cursorColor: Colors.grey,
                              controller: authProvider.email,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                hintText: "Email".tr,
                                icon: Icon(
                                  Icons.email,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: thirdColor,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Colors.green,
                              obscureText: authProvider.showPassword,
                              controller: authProvider.password,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: authProvider.showPassword
                                          ? Colors.grey
                                          : Colors.green,
                                    ),
                                    onPressed: () {
                                      authProvider.changePasswordVisible();
                                    },
                                  ),
                                  hintText: "Password".tr,
                                  icon: Icon(
                                    Icons.lock,
                                    color: primary,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () async {
                            if (!await authProvider.signIn()) {
                              _key.currentState.showSnackBar(
                                  SnackBar(content: Text("Login failed!")));
                              return;
                            }

                            authProvider.clearController();
                            changeScreenReplacement(context, ControlView());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: grey),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                    text: "Login".tr,
                                    color: Colors.white,
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () async {
                            changeScreen(context, RegistrationScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: grey),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                    text: "Register here!".tr,
                                    color: primaryColor,
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
