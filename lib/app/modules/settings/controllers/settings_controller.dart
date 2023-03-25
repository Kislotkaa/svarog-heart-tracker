import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/cache/start_app_cache.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/controllers/sqllite_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/device_controller.dart';
import '../../../helper/error_handler.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/base_dialog.dart';

class SettingsController extends GetxController {
  SettingsController({
    required this.startAppCache,
    required this.sqlLiteController,
    required this.bluetoothController,
  });

  final StartAppCache startAppCache;
  final SqlLiteController sqlLiteController;
  final BluetoothController bluetoothController;

  final RxBool isLoading = false.obs;

  void goToAbout() {
    Get.toNamed(Routes.ABOUT);
  }

  void goToHowToUse() {
    Get.toNamed(Routes.HOW_TO_USE);
  }

  void goToHistory() {
    Get.toNamed(Routes.HISTORY);
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

  void onTapDeleteHistory() {
    showBaseDialog(
      'Отчистить историю?',
      'Вы действительно хотите удалить историю и всё что с ней связано?',
      () => goToDeleteHistory(),
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

  Future<void> goToDeleteHistory() async {
    try {
      isLoading.value = true;

      await sqlLiteController.clearDataBase();
      var result = await bluetoothController.getConnectedDevices();
      result.forEach((element) async {
        await Get.delete<DeviceController>(tag: element.id.id);
      });

      await bluetoothController.disconnectDeviceAll();

      Get.back();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void goToBack() {
    Get.back(closeOverlays: true);
  }

  void goToUrl(String url) {
    launchUrl(Uri.parse(url));
  }

  @override
  Future<void> onInit() async {
    await sqlLiteController.dataBaseIsEmpty();
    super.onInit();
  }
}
