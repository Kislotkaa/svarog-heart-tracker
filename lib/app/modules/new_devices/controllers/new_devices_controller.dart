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
import 'package:svarog_heart_tracker/app/models/user_model.dart';
import 'package:svarog_heart_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:svarog_heart_tracker/app/repository/user_repository.dart';

import '../../../controllers/device_controller.dart';
import '../../../widgets/base_dialog.dart';

class NewDevicesController extends GetxController {
  NewDevicesController({
    required this.bluetoothController,
    required this.userRepository,
    required this.homeController,
    required this.permissionController,
  });

  final BluetoothController bluetoothController;
  final UserRepository userRepository;
  final HomeController homeController;
  final PermissionController permissionController;

  final RxBool isLoadingLinier = false.obs;

  final String textStatusDefault = 'Список доступных устройств';
  final RxString textStatus = RxString('');

  final RxList<NewDeviceModel> scanResult = RxList<NewDeviceModel>();
  final RxList<UserModel> previouslyConnected = RxList<UserModel>();

  final List<NewDeviceModel> connectedDevices = [];

  late StreamSubscription subscription;

  Future<void> scanDevices() async {
    try {
      isLoadingLinier.value = true;
      textStatus.value = 'Поиск свободных устройств...';
      previouslyConnected.clear();
      var results = await userRepository.getUsers();
      previouslyConnected.addAll(results);

      await bluetoothController.startScanDevice();
      scanResult.clear();
      bluetoothController.scanResultListen((results) {
        var result = results.where((element) =>
            element.advertisementData.serviceUuids.firstWhereOrNull(
                (element) => (element.toLowerCase()).contains('180d')) !=
            null);

        scanResult.clear();
        textStatus.value = '$textStatusDefault: ${result.length}';

        result.forEach((element) {
          String? deviceName = element.advertisementData.localName;
          String? deviceNumber = element.device.id.id;
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
          if (isPreviouslyConnected(blueDevice.id.id)) {
            var result = getNamePreviouslyDevice(blueDevice.id.id);
            await connect(blueDevice, result);
          } else {
            showDialogConnect(blueDevice);
          }
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
      await bluetoothController.connectToDevice(blueDevice);
      DeviceController deviceController = Get.put(
        DeviceController(
          device: blueDevice,
          name: name,
          id: blueDevice.id.id,
          userHistoryRepository: Get.find(),
          userRepository: Get.find(),
          homeController: Get.find(),
        ),
        tag: blueDevice.id.id,
      );
      homeController.addDevice(deviceController);
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
          connect(blueDevice, controller.text);
        }
      },
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  bool isPreviouslyConnected(String? id) {
    if (id != null) {
      return previouslyConnected
                  .firstWhereOrNull((element) => element.id == id) ==
              null
          ? false
          : true;
    }
    return false;
  }

  String getNamePreviouslyDevice(String? id) {
    if (id != null) {
      var result =
          previouslyConnected.firstWhereOrNull((element) => element.id == id);
      return result?.personName ?? 'Empty';
    }
    return 'Empty';
  }

  void _subscribeConnectedDevices() async {
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

  Future<void> _unSubscribeConnectedDevices() async {
    await subscription.cancel();
  }

  @override
  Future<void> onInit() async {
    _subscribeConnectedDevices();
    await scanDevices();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await _unSubscribeConnectedDevices();
    super.onClose();
  }

  @override
  void onReady() {
    permissionController.getPermission();
    super.onReady();
  }
}
