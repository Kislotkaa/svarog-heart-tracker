import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceConnectedController {
  DeviceConnectedController({
    required this.bluetoothDevice,
    required this.name,
    this.heartAvg = 0,
  });

  final BluetoothDevice bluetoothDevice;
  final String name;
  late int heartAvg;

  void onInit() {
    print(
        'initializing DeviceConnectedController = ${name}/${bluetoothDevice.name}');
  }

  void onClose() {
    print(
        'onClosed DeviceConnectedController = ${name}/${bluetoothDevice.name}');
  }
}
