import 'package:get/get.dart';

import '../controllers/new_devices_controller.dart';

class NewDevicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewDevicesController>(
      () => NewDevicesController(
        bluetoothController: Get.find(),
        homeController: Get.find(),
      ),
    );
  }
}
