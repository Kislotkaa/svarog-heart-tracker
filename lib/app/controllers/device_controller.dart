import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/helper/characteristic.dart';

class DeviceController extends GetxController {
  DeviceController({
    required this.device,
    required this.name,
    required this.id,
  });

  final BluetoothDevice device;
  final String name;
  final String id;

  final RxInt heartAvg = 0.obs;

  late List<BluetoothService> services = [];
  late StreamSubscription<List<int>> streamSubscription;

  Future<void> getServiceDevice() async {
    services = await device.discoverServices();
    BluetoothService? service;
    BluetoothCharacteristic? characteristics;

    await Future.delayed(Duration(seconds: 1));
    services.forEach((service) {
      Get.printInfo(info: 'SERVICE_ID: ${service.uuid}');
      service.characteristics.forEach((characteristic) async {
        Get.printInfo(info: 'CHARACTERISTIC_ID: ${characteristic.uuid}');
        Get.printInfo(info: 'CHARACTERISTIC: ${await characteristic.read()}');
        Get.printInfo(
            info:
                'CHARACTERISTIC_READ: ${String.fromCharCodes(await characteristic.read())}');
      });
    });

    service = getService(ble_service_tracker);
    characteristics = getCharacteristic(ble_heart_rate, service);
    if (characteristics != null) {
      await characteristics.setNotifyValue(true);
      streamSubscription = characteristics.value.listen((value) {
        heartAvg.value = value[1] ?? 0;
      });
    }
  }

  BluetoothService? getService(String serviceId) {
    return services
        .firstWhereOrNull((element) => element.uuid.toString() == serviceId);
  }

  BluetoothCharacteristic? getCharacteristic(
    String characteristicId,
    BluetoothService? serviceTracker,
  ) {
    if (serviceTracker != null) {
      return serviceTracker.characteristics.firstWhereOrNull(
          (element) => element.uuid.toString() == characteristicId);
    }
    return null;
  }

  @override
  Future<void> onReady() async {
    await getServiceDevice();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
