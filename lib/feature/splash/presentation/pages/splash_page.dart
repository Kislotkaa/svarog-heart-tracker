import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/utils/settings_utils.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _listenerCallback();

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _listenerCallback() async {
    await Future.delayed(const Duration(seconds: 1));

    StartAppModel? startAppModel = sl<SettingsUtils>().getFirstStartApp();

    if (startAppModel == null || startAppModel.isFirstStart == true) {
      sl<AppRouter>().pushAndPopUntil(const AuthAdminRoute(), predicate: (Route<dynamic> route) => false);
      return;
    }

    startAppModel.isHaveAuth
        ? sl<AppRouter>().pushAndPopUntil(const HomeRoute(), predicate: (Route<dynamic> route) => false)
        : sl<AppRouter>().pushAndPopUntil(const AuthRoute(), predicate: (Route<dynamic> route) => false);
  }
}
