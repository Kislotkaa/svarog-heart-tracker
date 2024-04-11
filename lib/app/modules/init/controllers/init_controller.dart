import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/routes/app_pages.dart';

import '../../../cache/start_app_cache.dart';
import '../../../models/start_app_model.dart';

class InitController extends GetxController {
  InitController({
    required this.appStartCache,
  });

  final StartAppCache appStartCache;

  final RxString statusLoading = 'Loading...'.obs;

  Future<void> getAppStartCache() async {
    await Future.delayed(const Duration(seconds: 1));
    StartAppModel? startAppModel = appStartCache.getData();

    if (kDebugMode) {
      Get.offAndToNamed(Routes.HOME);
      return;
    }

    if (startAppModel == null || startAppModel.isFirstStart == true) {
      Get.toNamed(Routes.ADMIN_PANEL);
      return;
    }

    startAppModel.isHaveAuth ? Get.offAndToNamed(Routes.HOME) : Get.offAndToNamed(Routes.AUTH);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await getAppStartCache();
  }

  @override
  void onInit() {
    // appStartCache.clearData();
    super.onInit();
  }
}
