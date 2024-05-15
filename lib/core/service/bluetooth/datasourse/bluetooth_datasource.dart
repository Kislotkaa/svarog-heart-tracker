import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/app_bluetooth_service.dart';

abstract class BluetoothDataSource {
  Future<List<BluetoothDevice>> getConnectedDevice();
}

class BluetoothDataSourceImpl extends BluetoothDataSource {
  final AppBluetoothService bluetoothService;

  BluetoothDataSourceImpl({required this.bluetoothService});

  @override
  Future<List<BluetoothDevice>> getConnectedDevice() async {
    final list = bluetoothService.getConnectedDevices();
    return list;
  }
}
