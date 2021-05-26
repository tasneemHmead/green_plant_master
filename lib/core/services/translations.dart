import 'package:get/get.dart';
import 'package:green_plant/helper/langs/ar.dart';
import 'package:green_plant/helper/langs/en.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
