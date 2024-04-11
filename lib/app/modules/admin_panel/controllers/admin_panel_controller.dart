import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/base_snackbar_controller.dart';

import '../../../cache/start_app_cache.dart';
import '../../../models/start_app_model.dart';
import '../../../routes/app_pages.dart';

class AdminPanelController extends GetxController {
  AdminPanelController({required this.startAppCache});
  StartAppCache startAppCache;

  Rx<CrossFadeState> crossState = Rx<CrossFadeState>(CrossFadeState.showFirst);
  final RxBool isLoading = false.obs;

  final TextEditingController password = TextEditingController();
  final TextEditingController repeatPassword = TextEditingController();

  late String? adminInstaller = '';

  final RxBool hasFocus = false.obs;

  void inFocus() => hasFocus.value = true;
  void unFocus(context) {
    hasFocus.value = false;
    FocusScope.of(context).unfocus();
  }

  @override
  Future<void> onInit() async {
    await loadingEnv();
    super.onInit();
  }

  Future<void> loadingEnv() async {
    await dotenv.load(fileName: '.env');
    final env = dotenv.env;
    adminInstaller = env['APP_INSTAL'];
    kDebugMode ? password.text = adminInstaller ?? '' : {};
  }

  void loginAdmin() {
    if (password.text == adminInstaller) {
      password.clear();
      crossState.value = CrossFadeState.showSecond;
    } else {
      showSnackbar(
        'Обратитесь к администратору за паролем',
        'Пароли не совпадают',
        status: SnackStatusEnum.error,
      );
    }
  }

  void setPassword() async {
    if (isLoading.value != true) {
      try {
        isLoading.value = true;
        if (password.text != repeatPassword.text) {
          showSnackbar(
            'Проверьте правильность ввода паролей и повторите попытку',
            'Пароли не совпадают',
            status: SnackStatusEnum.warning,
          );
          return;
        }
        if (password.text.isNullOrEmpty) {
          showSnackbar(
            'Пароль должен быть минимум один символ',
            'Пустых паролей не бывает',
            status: SnackStatusEnum.warning,
          );
          return;
        }
        var param = StartAppModel(
          isFirstStart: false,
          isHaveAuth: false,
          localPassword: password.text,
        );
        await startAppCache.setData(param.toJson());
        Get.offAndToNamed(Routes.AUTH);
      } catch (e) {
        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
