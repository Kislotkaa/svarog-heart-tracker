import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/controllers/permission_controller.dart';
import 'package:svarog_heart_tracker/app/helper/error_handler.dart';
import 'package:svarog_heart_tracker/app/models/new_device_model.dart';
import 'package:svarog_heart_tracker/app/modules/home/controllers/home_controller.dart';

import '../../../controllers/device_controller.dart';
import '../../../widgets/base_dialog.dart';

class NewDevicesController extends GetxController {
  NewDevicesController({
    required this.bluetoothController,
    required this.homeController,
    required this.permissionController,
  });

  final BluetoothController bluetoothController;
  final HomeController homeController;
  final PermissionController permissionController;

  final RxBool isLoadingLinier = false.obs;

  final String textStatusDefault = 'Список доступных устройств';
  final RxString textStatus = RxString('');

  final RxList<NewDeviceModel> scanResult = RxList<NewDeviceModel>();
  final List<NewDeviceModel> connectedDevices = [];

  late StreamSubscription subscription;

  Future<void> scanDevices() async {
    try {
      isLoadingLinier.value = true;
      textStatus.value = 'Поиск свободных устройств...';
      await bluetoothController.startScanDevice();
      scanResult.clear();
      bluetoothController.scanResultListen((results) {
        var result = results.where((element) =>
            element.advertisementData.serviceUuids.firstWhereOrNull(
                (element) => (element.toLowerCase()).contains('180d')) !=
            null);

        scanResult.clear();
        textStatus.value = '$textStatusDefault: ${result.length}';

        result.forEach((element) async {
          String? deviceName = await element.advertisementData.localName;
          String? deviceNumber = await element.device.id.id;
          var model = NewDeviceModel(
            blueDevice: element.device,
            deviceId: deviceNumber,
            deviceName: deviceName,
            deviceNumber: deviceNumber.toString(),
          );
          scanResult.add(model);
        });
      });

      scanResult.refresh();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {
      isLoadingLinier.value = false;
    }
  }

  Future<void> connectOrDisconnect(BluetoothDevice blueDevice) async {
    if (!isLoadingLinier.value) {
      try {
        isLoadingLinier.value = true;
        var result = connectedDevices.firstWhereOrNull(
            (element) => element.blueDevice.id.id == blueDevice.id.id);
        if (result != null) {
          showDialogDisconnect(result.blueDevice);
        } else {
          showDialogConnect(blueDevice);
        }
      } catch (e, s) {
        ErrorHandler.getMessage(e, s);
      } finally {
        isLoadingLinier.value = false;
      }
    }
  }

  Future<void> disconnect(BluetoothDevice blueDevice) async {
    try {
      isLoadingLinier.value = true;
      await bluetoothController.disconnectDevice(blueDevice);
      Get.delete<DeviceController>(tag: blueDevice.id.id);
      homeController.list
          .removeWhere((element) => blueDevice.id.id == element.device.id.id);
    } catch (e, s) {
    } finally {
      isLoadingLinier.value = false;
    }
  }

  Future<void> connect(BluetoothDevice blueDevice, String name) async {
    try {
      isLoadingLinier.value = true;
      Get.printInfo(info: 'DEBUG: connectToDevice');
      await bluetoothController.connectToDevice(blueDevice);
      Get.printInfo(info: 'DEBUG: connectedDevice');
      DeviceController deviceController = Get.put(
        DeviceController(
          device: blueDevice,
          name: name,
          id: blueDevice.id.id,
        ),
        tag: blueDevice.id.id,
      );
      homeController.addDevice(deviceController);
      Get.printInfo(info: 'DEBUG: add controller device');
    } catch (e, s) {
    } finally {
      isLoadingLinier.value = false;
    }
  }

  bool haveConnect(BluetoothDevice blueDevice) {
    var result = connectedDevices.firstWhereOrNull(
        (element) => blueDevice.id.id == element.blueDevice.id.id);
    if (result == null) return false;
    return true;
  }

  void showDialogDisconnect(BluetoothDevice blueDevice) {
    showBaseDialog(
      'Разорвать соединение?',
      'Вы действительно хотите разорвать соединение?',
      () async {
        Get.back();
        disconnect(blueDevice);
      },
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  void showDialogConnect(BluetoothDevice blueDevice) {
    DeviceController? model;
    TextEditingController controller = TextEditingController();
    if (kDebugMode) controller.text = 'Пробник';
    showBaseAddNameDialog(
      'Кто это?',
      controller,
      () async {
        if (controller.text.isNotEmpty) {
          Get.back();
          Get.printInfo(info: 'DEBUG: connect');
          connect(blueDevice, controller.text);
        }
      },
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  void _subscribeConnectedDevices() {
    final stream = Stream.periodic(const Duration(seconds: 1));
    subscription = stream.listen((event) async {
      if (!isLoadingLinier.value) {
        var list = await bluetoothController.getConnectedDevices();
        connectedDevices.clear();

        list.forEach((element) {
          var model = NewDeviceModel(
            blueDevice: element,
            deviceId: '',
            deviceName: '',
            deviceNumber: '',
          );
          connectedDevices.add(model);
        });

        this.scanResult.refresh();
      }
    });
  }

  void _unSubscribeConnectedDevices() {
    subscription.cancel();
  }

  @override
  Future<void> onInit() async {
    await scanDevices();
    _subscribeConnectedDevices();

    super.onInit();
  }

  @override
  void onClose() {
    _unSubscribeConnectedDevices();
    super.onClose();
  }

  @override
  void onReady() {
    permissionController.getPermission();
    super.onReady();
  }
}
