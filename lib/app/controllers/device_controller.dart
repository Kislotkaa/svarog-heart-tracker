import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceController {
  DeviceController({
    required this.bluetoothDevice,
    required this.name,
    this.heartAvg = 0,
  });

  final BluetoothDevice bluetoothDevice;
  final String name;
  late int heartAvg;

  void onInit() {
    print('initializing DeviceController = ${name}/${bluetoothDevice.name}');
  }

  void onClose() {
    print('onClosed DeviceController = ${name}/${bluetoothDevice.name}');
  }
}
