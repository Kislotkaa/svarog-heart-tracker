import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'app/inject/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await runMyApp();
}

Future<void> runMyApp() async {
  runApp(
    App(
      languagesAppController: Get.find(),
      themeController: Get.find(),
    ),
  );
}
