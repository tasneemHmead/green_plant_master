import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:green_plant/helper/local_storage/local_storgae.dart';

class AppLanguage extends GetxController {
  var appLocale = 'ar';

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    appLocale = await localStorage.languageSelected == null
        ? 'ar'
        : await localStorage.languageSelected;
    update();
    Get.updateLocale(Locale(appLocale));
  }

  void changeLanguage() async {
    LocalStorage localStorage = LocalStorage();

    if (appLocale == 'ar') {
      appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
      Get.updateLocale(Locale('en'));
    } else {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
      Get.updateLocale(Locale('ar'));
    }
    update();
  }
}
