import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:svarog_heart_tracker/app/controllers/base_snackbar_controller.dart';

class ErrorHandler {
  static getMessage(dynamic e, StackTrace s) async {
    if (e is FormatException) {
      showSnackbar(e.message, 'Ошибка');
    } else if (e is PlatformException) {
      if (e.code.contains('bluetooth')) {
        Get.printError(info: e.toString());
        Get.printError(info: s.toString());
      }
    } else {
      Get.printError(info: e.toString());
      Get.printError(info: s.toString());
      Sentry.captureException(e, stackTrace: s);
    }
  }
}
