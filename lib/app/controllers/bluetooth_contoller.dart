import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../helper/error_handler.dart';
import 'base_snackbar_controller.dart';

class BluetoothController extends GetxController {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  RxList<ScanResult> scanResult = RxList<ScanResult>();
  RxList<BluetoothDevice> connectedDevices = RxList<BluetoothDevice>();

  Future<void> scanDevice() async {
    try {
      if (await validBlue()) {
        await flutterBlue.startScan(
          timeout: const Duration(seconds: 4),
        );

        flutterBlue.scanResults.listen((results) {
          var filterResilt = results.where((element) =>
              element.advertisementData.serviceUuids.contains('180D'));
          scanResult.clear();
          scanResult.addAll(filterResilt);
        });
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {}
  }

  Future<void> getConnectedDevices() async {
    try {
      var result = await flutterBlue.connectedDevices;
      connectedDevices.clear();
      connectedDevices.addAll(result);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> connectOrDisconnect(ScanResult blueDevice) async {
    try {
      var result = connectedDevices.firstWhereOrNull(
          (element) => element.id.id == blueDevice.device.id.id);
      if (result != null) {
        await _disconnectDevice(blueDevice);
      } else {
        await _connectToDevice(blueDevice);
        await getConnectedDevices();
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _connectToDevice(ScanResult blueDevice) async =>
      await blueDevice.device.connect();

  Future<void> _disconnectDevice(ScanResult blueDevice) async {
    connectedDevices
        .removeWhere((element) => element.id.id == blueDevice.device.id.id);
    await blueDevice.device.disconnect();
  }

  bool haveConnectDevice(ScanResult blueDevice) {
    var result = connectedDevices
        .firstWhereOrNull((element) => blueDevice.device.id == element.id);
    if (result == null) return false;
    return true;
  }

  Future<bool> validBlue() async {
    if ((await flutterBlue.isAvailable) == false) {
      showSnackbar(
        'Устройство не подерживается',
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
}
