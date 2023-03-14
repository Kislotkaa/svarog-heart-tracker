import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import 'base_snackbar_controller.dart';

class BluetoothController extends GetxController {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  StreamSubscription<List<ScanResult>> Function(
          void Function(List<ScanResult> event)? onData,
          {bool? cancelOnError,
          void Function()? onDone,
          Function? onError})
      get scanResultListen => flutterBlue.scanResults.listen;

  Stream<List<BluetoothDevice>> get streamConnected =>
      flutterBlue.connectedDevices.asStream();

  Future<void> startScanDevice() async {
    if (await validBlue()) {
      await flutterBlue.startScan(
        scanMode: ScanMode.lowPower,
        timeout: const Duration(seconds: 4),
      );
    }
  }

  Future<List<BluetoothDevice>> getConnectedDevices() async {
    List<BluetoothDevice> connectedDevices = [];
    var result = await flutterBlue.connectedDevices;
    connectedDevices.clear();
    connectedDevices.addAll(result);
    return connectedDevices;
  }

  Future<void> connectToDevice(BluetoothDevice blueDevice) async {
    await blueDevice.connect(autoConnect: false);
  }

  Future<void> disconnectDevice(BluetoothDevice blueDevice) async {
    await blueDevice.disconnect();
  }

  Future<void> disconnectDeviceAll() async {
    var connectedDevices = await getConnectedDevices();
    for (var element in connectedDevices) {
      await element.disconnect();
    }
  }

  Future<bool> validBlue() async {
    if ((await flutterBlue.isAvailable) == false) {
      getEmptySnackBar();

      return false;
    } else if ((await flutterBlue.isOn) == false) {
      getDisabledSnackBar();

      return false;
    }
    return true;
  }

  void getEmptySnackBar() {
    showSnackbar(
      'Устройство Bluetooth не обнаружено',
      'Ошибка',
      status: SnackStatusEnum.error,
    );
  }

  void getDisabledSnackBar() {
    showSnackbar(
      'Bluetooth модуль устройства выключен',
      'Статус: Выключен',
      status: SnackStatusEnum.warning,
    );
  }

  void getPermissionSnackBar(context) {
    showSnackbar(
      'Устройство не получило доступ к Bluetooth',
      'Ошибка доступа',
      status: SnackStatusEnum.warning,
    );
  }

  void getConnectedSnackBar() {
    showSnackbar(
      'В данный момент Bluetooth используется',
      'Статус: Используется',
      status: SnackStatusEnum.access,
    );
  }

  void getDefaultSnackBar() {
    showSnackbar(
      'Модуль Bluetooth включён но не используется',
      'Статус: Включён',
      status: SnackStatusEnum.access,
    );
  }

  void getSearchingSnackBar() {
    showSnackbar(
      'Модуль Bluetooth ищет устройства побблизости',
      'Статус: Поиск',
      status: SnackStatusEnum.access,
    );
  }

  @override
  Future<void> onInit() async {
    await disconnectDeviceAll();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await disconnectDeviceAll();
    super.onClose();
  }
}
