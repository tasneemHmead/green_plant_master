import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:green_plant/provider/user_prov.dart';
import 'package:green_plant/screens/auth/choose_auth_method_view.dart';
import 'package:green_plant/screens/control_view.dart';
import 'package:green_plant/widget/empty_content.dart';

import 'core/services/notification_service.dart';
import 'core/services/translations.dart';
import 'core/viewmodel/app_language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  NotificationService().init();

  runApp(
    ProviderScope(
      child: ScreenController(),
    ),
  );
}

class ScreenController extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    final authStateChanges = watch(authStateChangesProvider);
    return GetBuilder(
      init: AppLanguage(),
      builder: (AppLanguage controller) {
        return GetMaterialApp(
          navigatorObservers: [VillainTransitionObserver()],
          translations: Translation(),
          locale: Locale('en'),
          fallbackLocale: Locale('en'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Nexa',
            scaffoldBackgroundColor: Colors.white,
          ),
          home: authStateChanges.when(
            data: (user) {
              if (user != null) {
                return ControlView();
              }
              return ChooseAuthMethodView();
            },
            loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => const Scaffold(
              body: EmptyContent(
                title: 'Something went wrong',
                message: 'Can\'t load data right now.',
              ),
            ),
          ),
        );
      },
    );
  }
}
