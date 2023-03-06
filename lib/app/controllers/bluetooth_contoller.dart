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
    if (await _validBlue()) {
      await flutterBlue.startScan(
        scanMode: ScanMode.lowLatency,
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
    await blueDevice.connect();
  }

  Future<void> disconnectDevice(BluetoothDevice blueDevice) async {
    await blueDevice.disconnect();
  }

  Future<void> _disconnectDeviceAll() async {
    var connectedDevices = await getConnectedDevices();
    for (var element in connectedDevices) {
      await element.disconnect();
    }
  }

  Future<bool> _validBlue() async {
    if ((await flutterBlue.isAvailable) == false) {
      showSnackbar(
        'Устройство не может получить доступ к Bluetooth',
        'Ошибка',
        status: SnackStatusEnum.error,
      );

      return false;
    } else if ((await flutterBlue.isOn) == false) {
      getDisabledSnackBar();

      return false;
    }
    return true;
  }

  void getDisabledSnackBar() {
    showSnackbar(
      'Bluetooth модуль устройства выключен',
      'Статус: Выключен',
      status: SnackStatusEnum.warning,
    );
  }

  @override
  Future<void> onInit() async {
    await _disconnectDeviceAll();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await _disconnectDeviceAll();
    super.onClose();
  }
}
