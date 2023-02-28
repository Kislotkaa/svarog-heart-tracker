import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/language_app_controller.dart';
import 'controllers/theme_controller.dart';
import 'resourse/app_strings.dart';
import 'routes/app_pages.dart';

class App extends StatelessWidget {
  final LanguagesAppController languagesAppController;
  final ThemeController themeController;
  const App({
    Key? key,
    required this.languagesAppController,
    required this.themeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Heart tracker",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: themeController.currentTheme(),
      locale: Locale(languagesAppController.getCache() ?? 'ru_RU'),
      translations: AppStrings(),
    );
  }
}
