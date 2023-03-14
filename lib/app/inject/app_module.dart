import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svarog_heart_tracker/app/cache/start_app_cache.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/controllers/permission_controller.dart';

import '../cache/language_cache_datasource.dart';
import '../controllers/base_snackbar_controller.dart';
import '../controllers/language_app_controller.dart';
import '../controllers/theme_controller.dart';

Future<void> initAppModule() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDateFormatting();
  await GetStorage.init();

  await _initApi();
  _initDataSource();
  _initInteractor();
  _initRepositories();
  _initControllers();
}

Future<void> _initApi() async {}

void _initInteractor() {}

void _initDataSource() {
  Get
    ..put(LanguageCacheDataSource())
    ..put(StartAppCache());
}

void _initRepositories() {}

void _initControllers() {
  Get
    ..put(BaseSnackbarController())
    ..put(BluetoothController())
    ..put(ThemeController())
    ..put(LanguagesAppController(cache: Get.find()))
    ..put(PermissionController());
}
