import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class NewDeviceModel {
  NewDeviceModel({
    required this.deviceId,
    required this.deviceNumber,
    required this.deviceName,
    required this.blueDevice,
  });

  final String deviceId;
  final String deviceNumber;
  final String deviceName;
  final BluetoothDevice blueDevice;
}
