import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/cache/start_app_cache.dart';
import 'package:svarog_heart_tracker/app/routes/app_pages.dart';

import '../../../controllers/base_snackbar_controller.dart';
import '../../../models/start_app_model.dart';

class AuthController extends GetxController {
  AuthController({
    required this.startAppCache,
  });

  final StartAppCache startAppCache;

  final TextEditingController password = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool hasFocus = false.obs;

  void inFocus() => hasFocus.value = true;
  void unFocus(context) {
    hasFocus.value = false;
    FocusScope.of(context).unfocus();
  }

  Future<void> login() async {
    if (isLoading.value != true) {
      isLoading.value = true;

      StartAppModel? result = startAppCache.getData();

      if (result == null || result.localPassword == null) {
        startAppCache.clearData();
        Get.offAndToNamed(Routes.ADMIN_PANEL);
      } else if (result.localPassword == password.text) {
        var param = result.copyWith(isHaveAuth: true);
        await startAppCache.setData(param.toJson());
        Get.offAndToNamed(Routes.HOME);
      } else {
        showSnackbar(
          'Не верный пароль, проверьте правильность ввода и повторите попытку',
          'Пароль не верный',
          status: SnackStatusEnum.warning,
        );
      }
      try {} catch (e, s) {
      } finally {
        isLoading.value = false;
      }
    }
  }
}
