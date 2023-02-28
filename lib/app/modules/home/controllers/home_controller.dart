import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';

class HomeController extends GetxController {
  HomeController({
    required this.bluetoothController,
  });

  final BluetoothController bluetoothController;

  RxBool isLoading = false.obs;
  RxBool isLoadingLinier = false.obs;

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
