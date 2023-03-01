import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class DeviceConnectedModel extends GetxController {
  DeviceConnectedModel({
    required this.bluetoothDevice,
    required this.name,
    this.heartAvg = 0,
  });

  final BluetoothDevice bluetoothDevice;
  final String name;
  late int heartAvg;
}
