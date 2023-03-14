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
    try {
      services = await device.discoverServices();
      BluetoothService? service;
      BluetoothCharacteristic? characteristic;
      BluetoothDescriptor? descriptor;

      _getConsoleService(false); // показать все доступные сервисы

      service = _getService(ble_service_tracker);
      characteristic = _getCharacteristic(ble_character_heart_rate, service);

      if (characteristic != null) {
        await characteristic.setNotifyValue(true);
        streamSubscription = characteristic.value.listen((value) {
          setHeartAvg(value[1]);
        });
      }
    } catch (e, s) {}
  }

  void setHeartAvg(int? value) {
    if (value != null) {
      heartAvg.value = value;
    }
  }

  BluetoothService? _getService(String serviceId) {
    return services
        .firstWhereOrNull((element) => element.uuid.toString() == serviceId);
  }

  Future<void> _getConsoleService(bool isActive) async {
    if (isActive) {
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
    }
  }

  BluetoothCharacteristic? _getCharacteristic(
    String characteristicId,
    BluetoothService? serviceTracker,
  ) {
    if (serviceTracker != null) {
      return serviceTracker.characteristics.firstWhereOrNull(
          (element) => element.uuid.toString() == characteristicId);
    }
    return null;
  }

  BluetoothDescriptor? _getDescriptor(
    String descriptorId,
    BluetoothCharacteristic? characteristic,
  ) {
    if (characteristic != null) {
      return characteristic.descriptors.firstWhereOrNull(
          (element) => element.uuid.toString() == descriptorId);
    }
    return null;
  }

  @override
  Future<void> onReady() async {
    await getServiceDevice();
    super.onReady();
  }
}
