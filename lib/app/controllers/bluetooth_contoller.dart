import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/device_controller.dart';

import '../helper/error_handler.dart';
import '../widgets/base_dialog.dart';
import 'base_snackbar_controller.dart';

class BluetoothController extends GetxController {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  RxList<ScanResult> scanResult = RxList<ScanResult>();
  RxList<BluetoothDevice> connectedDevices = RxList<BluetoothDevice>();
  RxList<DeviceController> activeDevices = RxList<DeviceController>();

  Future<void> scanDevice() async {
    try {
      if (await validBlue()) {
        await flutterBlue.startScan(
          scanMode: ScanMode.lowLatency,
          timeout: const Duration(seconds: 4),
        );

        await getConnectedDevices();

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
      scanResult.refresh();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> connectOrDisconnect(ScanResult blueDevice) async {
    try {
      var result = connectedDevices.firstWhereOrNull(
          (element) => element.id.id == blueDevice.device.id.id);
      if (result != null) {
        showBaseDialog(
          'Разорвать соединение?',
          'Вы действительно хотите разорвать соединение?',
          () async {
            Get.back();
            await _disconnectDevice(blueDevice);
          },
          () => Get.back(),
          'Подтвердить',
          'Отмена',
        );
      } else {
        DeviceController? model;
        TextEditingController controller = TextEditingController();
        showBaseAddNameDialog(
          'Кто это?',
          controller,
          () async {
            if (controller.text.isNotEmpty) {
              DeviceController model = DeviceController(
                bluetoothDevice: blueDevice.device,
                name: controller.text,
                heartAvg: 0,
              );
              Get.back();
              await _connectToDevice(model);
            }
          },
          () => Get.back(),
          'Подтвердить',
          'Отмена',
        );
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {}
  }

  Future<void> _connectToDevice(DeviceController model) async {
    await model.bluetoothDevice.connect();
    await getConnectedDevices();
    activeDevices.add(model);
    model.onInit();
  }

  Future<void> _disconnectDevice(ScanResult blueDevice) async {
    await blueDevice.device.disconnect();

    await getConnectedDevices();

    activeDevices.forEach((element) {
      if (element.bluetoothDevice.id.id == blueDevice.device.id.id) {
        element.onClose();
      }
    });

    activeDevices.removeWhere(
        (element) => element.bluetoothDevice.id.id == blueDevice.device.id.id);
  }

  Future<void> _disconnectDeviceAll() async {
    await getConnectedDevices();
    connectedDevices.forEach((element) async {
      await element.disconnect();
    });
    await getConnectedDevices();
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
  Future<void> onClose() async {
    await _disconnectDeviceAll();
    super.onClose();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }
}
