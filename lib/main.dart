import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/app.dart';
import 'app/inject/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await runMyApp();
}

Future<void> runMyApp() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://7cf307e0fa8a4b03829211c2c30cb122@o1165796.ingest.sentry.io/4504841419161600';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      App(
        languagesAppController: Get.find(),
        themeController: Get.find(),
      ),
    ),
  );
}
