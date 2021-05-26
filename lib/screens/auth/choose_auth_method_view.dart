import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:green_plant/core/viewmodel/app_language.dart';
import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/provider/user_prov.dart';
import 'package:green_plant/screens/auth/login.dart';
import 'package:green_plant/screens/auth/signup.dart';
import 'package:green_plant/widget/button/custom_button_with_icon.dart';
import 'package:green_plant/widget/coustm_text.dart';

class ChooseAuthMethodView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(userProvider);
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            GetBuilder<AppLanguage>(
              init: AppLanguage(),
              builder: (controller) {
                return ListTile(
                  title: Text(
                    'change_language'.tr,
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                  onTap: () async {
                    controller.changeLanguage();
                  },
                );
              },
            ),
            Image.asset(
              'images/logo.png',
              height: 300,
              width: Get.width,
            ),
            SizedBox(
              height: 50,
            ),
            CustomButtonWithIcon(
              text: 'Sign in With Google'.tr,
              backgroundColor: primaryColor.withOpacity(0.6),
              imageName: 'images/google.png',
              onPress: () async {
                await viewModel.signInWithGoogle();
              },
              fontSize: 20,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: secondaryColor,
                ),
                onPressed: () {
                  Get.to(() => RegistrationScreen());
                },
                child: Text(
                  "I will use email".tr,
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Already have an account ? '.tr,
                  size: 12,
                  color: primaryColor,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  child: CustomText(
                    text: 'Login here'.tr,
                    size: 14,
                    color: Colors.lightGreen,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
