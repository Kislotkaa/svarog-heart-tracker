import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/controllers/device_controller.dart';
import 'package:svarog_heart_tracker/app/helper/error_handler.dart';
import 'package:svarog_heart_tracker/app/modules/new_devices/views/new_devices_view.dart';
import 'package:svarog_heart_tracker/app/repository/user_repository.dart';
import 'package:svarog_heart_tracker/app/routes/app_pages.dart';

import '../../../models/user_model.dart';
import '../../../widgets/base_dialog.dart';

class HomeController extends GetxController {
  HomeController({
    required this.bluetoothController,
    required this.userRepository,
  });

  final BluetoothController bluetoothController;
  final UserRepository userRepository;

  final RxList<DeviceController> list = RxList<DeviceController>();
  late List<UserModel> listConnected = [];
  RxBool isLoadingLinier = false.obs;

  bool isScanning = true;
  late StreamSubscription<dynamic> streamSubscription;

  Future<void> goToNewDevice() async {
    if ((await bluetoothController.flutterBlue.isOn)) {
      isScanning = false;

      await showNewDevices().then((value) {
        isScanning = true;
      });
    } else {
      bluetoothController.validBlue();
    }
  }

  Future<void> goToSettings() async {
    isScanning = false;
    await Get.toNamed(Routes.SETTINGS)?.then((value) async {
      await getConnectedDevice();
      await getUsersConnected();
      isScanning = true;
    });
  }

  Future<void> goToDetailHistory(String id) async {
    isScanning = false;

    await Get.toNamed(Routes.HISTORY_DETAIL, arguments: id)
        ?.then((value) async {
      await getConnectedDevice();
      await getUsersConnected();
      isScanning = true;
    });
  }

  void addDevice(DeviceController device) {
    var result = list.firstWhereOrNull((element) => element.id == device.id);
    if (result == null) {
      list.add(device);
    } else {
      list.removeWhere((element) => element.id == device.id);
      list.add(device);
    }
    list.refresh();
  }

  void disconectDevice(dynamic device) {
    if (device is DeviceController) {
      bluetoothController.disconnectDevice(device.device);
      Get.delete<DeviceController>(tag: device.id);
      list.removeWhere((element) => device.id == element.device.id.id);
    } else if (device is BluetoothDevice) {
      bluetoothController.disconnectDevice(device);
      Get.delete<DeviceController>(tag: device.id.id);
      list.removeWhere((element) => device.id.id == element.device.id.id);
    }
  }

  void removeDevice(dynamic device) {
    showBaseDialog(
      'Разорвать соединение?',
      'Вы действительно хотите разорвать соединение?',
      () async {
        disconectDevice(device);
        Get.back();
      },
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  Future<void> getConnectedDevice() async {
    var resultDevice = await bluetoothController.getConnectedDevices();
    list.forEach((elementList) {
      bool isHave = false;
      resultDevice.forEach((elementResult) {
        if (elementList.id == elementResult.id.id) {
          isHave = true;
        }
      });
      if (isHave == false) {
        list.removeWhere((element) => element.id == elementList.id);
      }
    });
  }

  Future<void> getUsersConnected() async {
    try {
      listConnected = await userRepository.getUsers();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _subscribeAutoConnecting() async {
    final stream = Stream.periodic(const Duration(seconds: 6));
    await getUsersConnected();
    streamSubscription = stream.listen((event) async {
      if (isScanning) {
        await bluetoothController.startScanDevice();

        bluetoothController.scanResultListen((results) async {
          var result = results.where((element) =>
              element.advertisementData.serviceUuids.firstWhereOrNull(
                  (element) => (element.toLowerCase()).contains('180d')) !=
              null);

          result.forEach((elementDevice) async {
            var result = listConnected.firstWhereOrNull((elementConnected) =>
                elementConnected.id == elementDevice.device.id.id);
            if (result != null && result.isAutoConnect == true) {
              await connect(elementDevice.device, result.personName);
            }
          });
        });
      }
    });
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
      addDevice(deviceController);
    } catch (e, s) {
    } finally {
      isLoadingLinier.value = false;
    }
  }

  Future<void> _unSubscribeAutoConnecting() async {
    try {
      await streamSubscription.cancel();
    } catch (e, s) {}
  }

  @override
  Future<void> onReady() async {
    await _subscribeAutoConnecting();
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    await _unSubscribeAutoConnecting();
    super.onClose();
  }
}
