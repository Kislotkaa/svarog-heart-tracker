import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:svarog_heart_tracker/app.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';

class ErrorHandler {
  static getMessage(dynamic e, StackTrace s) async {
    if (e is FormatException) {
      AppSnackbar.showTextFloatingSnackBar(
        title: 'Ошибка',
        description: e.toString(),
        status: SnackStatusEnum.error,
        overlayState: Overlay.of(externalContext),
      );
    } else if (e is PlatformException) {
      if (e.code.contains('bluetooth')) {
        log(e.toString());
        log(s.toString());
      }
    } else {
      log(e.toString());
      log(s.toString());
      Sentry.captureException(e, stackTrace: s);
    }
  }
}
