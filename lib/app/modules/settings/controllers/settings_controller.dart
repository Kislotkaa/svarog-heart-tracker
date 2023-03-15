import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/cache/start_app_cache.dart';
import 'package:svarog_heart_tracker/app/models/start_app_model.dart';

import '../../../helper/error_handler.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/base_dialog.dart';

class SettingsController extends GetxController {
  SettingsController({required this.startAppCache});

  final StartAppCache startAppCache;
  final RxBool isLoading = false.obs;

  void goToAbout() {
    Get.toNamed(Routes.ABOUT);
  }

  Future<void> onTapLogout() async {
    showBaseDialog(
      'Выйти?',
      'Вы действительно хотите выйти с аккаунта?',
      () => goToLogout(),
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  Future<void> goToLogout() async {
    try {
      isLoading.value = true;
      var result = startAppCache.getData();
      if (result != null) {
        var param = result.copyWith(isHaveAuth: false);
        await startAppCache.setData(param.toJson());
        Get.offAndToNamed(Routes.AUTH);
      } else {
        startAppCache.clearData();
        Get.offAndToNamed(Routes.ADMIN_PANEL);
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onTapDeleteAccount() async {
    showBaseDialog(
      'Удалить аккаунт?',
      'Вы действительно хотите удалить аккаунт?',
      () => goToLogoutAndDelete(),
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  Future<void> goToLogoutAndDelete() async {
    try {
      isLoading.value = true;
      startAppCache.clearData();
      Get.offAllNamed(Routes.ADMIN_PANEL);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void goToBack() {
    Get.back(closeOverlays: true);
  }
}
