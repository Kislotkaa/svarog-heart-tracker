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
    BluetoothService? serviceTracker;
    BluetoothCharacteristic? heartRateCharacteristics;

    serviceTracker = services.firstWhereOrNull(
        (element) => element.uuid.toString() == ble_service_tracker);
    if (serviceTracker != null) {
      heartRateCharacteristics = serviceTracker.characteristics
          .firstWhereOrNull(
              (element) => element.uuid.toString() == ble_heart_rate);
    }
    if (heartRateCharacteristics != null) {
      await heartRateCharacteristics.setNotifyValue(true);
      streamSubscription = heartRateCharacteristics.value.listen((value) {
        heartAvg.value = value[1] ?? 0;
      });
    }
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
