import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/modules/new_devices/views/new_devices_view.dart';
import 'package:svarog_heart_tracker/app/routes/app_pages.dart';

class HomeController extends GetxController {
  HomeController({
    required this.bluetoothController,
  });

  final BluetoothController bluetoothController;

  RxBool isLoading = false.obs;
  RxBool isLoadingLinier = false.obs;

  Future<void> addDeviceBluetooth() async {
    if ((await bluetoothController.flutterBlue.isOn)) {
      showNewDevices();
    } else {
      bluetoothController.getDisabledSnackBar();
    }
  }

  void goToAbout() {
    Get.toNamed(Routes.ABOUT);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
