import 'package:get/get.dart';

import '../controllers/history_detail_controller.dart';

class HistoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryDetailController>(
      () => HistoryDetailController(
        bluetoothController: Get.find(),
        userHistoryRepository: Get.find(),
        userRepository: Get.find(),
      ),
    );
  }
}
