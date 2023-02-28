import 'dart:io';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/base_snackbar_controller.dart';

class ErrorHandler {
  static getMessage(dynamic e, StackTrace s) async {
    if (e is FormatException) {
      showSnackbar(e.message, 'Ошибка');
      Get.printError(info: e.message);
      Get.printError(info: s.toString());
    }
  }
}

class DioError {}
