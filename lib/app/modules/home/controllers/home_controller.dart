import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/controllers/device_controller.dart';
import 'package:svarog_heart_tracker/app/modules/new_devices/views/new_devices_view.dart';
import 'package:svarog_heart_tracker/app/routes/app_pages.dart';

import '../../../widgets/base_dialog.dart';

class HomeController extends GetxController {
  HomeController({
    required this.bluetoothController,
  });

  final BluetoothController bluetoothController;

  final RxList<DeviceController> list = RxList<DeviceController>();

  RxBool isLoadingLinier = false.obs;

  Future<void> goToNewDevice() async {
    if ((await bluetoothController.flutterBlue.isOn)) {
      showNewDevices();
    } else {
      bluetoothController.validBlue();
    }
  }

  void goToSettings() {
    Get.toNamed(Routes.SETTINGS);
  }

  void addDevice(DeviceController device) {
    list.add(device);
  }

  void removeDevice(dynamic device) {
    showBaseDialog(
      'Разорвать соединение?',
      'Вы действительно хотите разорвать соединение?',
      () async {
        if (device is DeviceController) {
          bluetoothController.disconnectDevice(device.device);
          Get.delete<DeviceController>(tag: device.id);
          list.removeWhere((element) => device.id == element.device.id.id);
        } else if (device is BluetoothDevice) {
          bluetoothController.disconnectDevice(device);
          Get.delete<DeviceController>(tag: device.id.id);
          list.removeWhere((element) => device.id.id == element.device.id.id);
        }
        Get.back();
      },
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }
}
