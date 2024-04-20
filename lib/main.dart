import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:svarog_heart_tracker/app.dart';
import 'package:svarog_heart_tracker/locator.dart' as di;

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await di.init();

    await SentryFlutter.init(
      (options) {
        options.dsn = 'https://7cf307e0fa8a4b03829211c2c30cb122@o1165796.ingest.sentry.io/4504841419161600';
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(
        const App(),
      ),
    );

    runApp(const App());
  }, (e, s) async {
    log(e.toString());
    log(s.toString());
  });
}
