import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';

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

Future<void> _initApi() async {
  await dotenv.load(fileName: '.env');
  final env = dotenv.env;
  final graphqlEndpoint = env['GRAPHQL_ENDPOINT'];
  final graphqlWsEndpoint = env['GRAPHQL_WS_ENDPOINT'];
  final apiBaseUrl = env['API_BASE_URL'];
  final storageBaseUrl = env['STORAGE_BASE_URL'];
}

void _initInteractor() {}

void _initDataSource() {
  Get.put(LanguageCacheDataSource());
}

void _initRepositories() {}

void _initControllers() {
  Get
    ..put(BaseSnackbarController())
    ..put(BluetoothController())
    ..put(ThemeController())
    ..put(LanguagesAppController(cache: Get.find()));
}
