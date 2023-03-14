import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/cache/start_app_cache.dart';
import 'package:svarog_heart_tracker/app/models/start_app_model.dart';

import '../../../controllers/base_snackbar_controller.dart';
import '../../../routes/app_pages.dart';

class AdminSetPasswordController extends GetxController {
  AdminSetPasswordController({
    required this.startAppCache,
  });
  StartAppCache startAppCache;

  final TextEditingController password = TextEditingController();
  final RxBool isLoading = false.obs;

  setPassword() async {
    if (isLoading.value != true) {
      try {
        isLoading.value = true;
        if (password.text.isNotNullOrEmpty) {
          var param = StartAppModel(
            isFirstStart: false,
            isHaveAuth: false,
            localPassword: password.text,
          );
          await startAppCache.setData(param.toJson());
          Get.offAndToNamed(Routes.AUTH);
        } else {
          showSnackbar(
            'Пароль должен быть минимум один символ',
            'Пустых паролей не бывает',
            status: SnackStatusEnum.warning,
          );
        }
      } catch (e, s) {
      } finally {
        isLoading.value = false;
      }
    }
  }
}
