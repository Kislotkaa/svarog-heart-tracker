import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/date_symbol_data_local.dart';
import 'package:svarog_heart_tracker/app/cache/start_app_cache.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/controllers/permission_controller.dart';
import 'package:svarog_heart_tracker/app/repository/user_history_repository.dart';
import 'package:svarog_heart_tracker/app/repository/user_repository.dart';

import '../cache/language_cache_datasource.dart';
import '../controllers/base_snackbar_controller.dart';
import '../controllers/language_app_controller.dart';
import '../controllers/sqllite_controller.dart';
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

Future<void> _initApi() async {
  await Get.put(SqlLiteController()).init();
}

void _initInteractor() {}

void _initDataSource() {
  Get
    ..put(LanguageCacheDataSource())
    ..put(StartAppCache());
}

void _initRepositories() {
  Get
    ..put(UserHistoryRepository())
    ..put(UserRepository());
}

void _initControllers() {
  Get
    ..put(BluetoothController())
    ..put(ThemeController())
    ..put(LanguagesAppController(cache: Get.find()))
    ..put(PermissionController())
    ..put(BaseSnackbarController());
}
