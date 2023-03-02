import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';

class NewDevicesController extends GetxController {
  NewDevicesController({
    required this.bluetoothController,
  });

  final BluetoothController bluetoothController;

  final RxBool isLoadingLinier = false.obs;
  final RxBool isGlobalLoading = false.obs;

  final String textStatusDefault = 'Список доступных устройств';
  final RxString textStatus = RxString('');

  RxList<ScanResult> get list => bluetoothController.scanResult;

  Future<void> scanDevices() async {
    isLoadingLinier.value = true;
    textStatus.value = 'Поиск устройств поблизости...';
    await bluetoothController.scanDevice();
    textStatus.value = textStatusDefault;
    isLoadingLinier.value = false;
  }

  Future<void> connectOrDisconnect(ScanResult blueDevice) async {
    isGlobalLoading.value = true;
    await bluetoothController.connectOrDisconnect(blueDevice);
    await bluetoothController.getConnectedDevices();
    list.refresh();

    isGlobalLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    await bluetoothController.getConnectedDevices();
    await scanDevices();

    textStatus.value = '$textStatusDefault: ${list.length}';
    super.onInit();
  }
}
