import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';

class AppBluetoothService extends Disposable {
  Stream<List<ScanResult>> get scanResulStream => FlutterBluePlus.scanResults;
  Stream<bool> get isScanning => FlutterBluePlus.isScanning;
  Future<bool> get isSupported async => await FlutterBluePlus.isSupported;
  List<ScanResult> get scanResult => FlutterBluePlus.lastScanResults;

  Future<void> startScanDevice({int scanSeconds = 3}) async {
    if (!FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.startScan(
        // withServices: [Guid('180d')],
        androidScanMode: AndroidScanMode.lowPower,
        timeout: null,
      );
    }
  }

  Future<void> stopScanDevice() async {
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
    }
  }

  Future<List<BluetoothDevice>> getConnectedDevices() async {
    List<BluetoothDevice> connectedDevices = [];
    var result = FlutterBluePlus.connectedDevices;
    connectedDevices.addAll(result);
    return connectedDevices;
  }

  Future<void> connectToDevice(BluetoothDevice blueDevice) async {
    await blueDevice.connect(autoConnect: true);
  }

  Future<void> disconnectDevice(BluetoothDevice blueDevice) async {
    await blueDevice.disconnect();
  }

  Future<void> disconnectDeviceAll() async {
    var connectedDevices = await getConnectedDevices();
    for (var element in connectedDevices) {
      await element.disconnect();
    }
  }

  Future<void> initial() async {
    await disconnectDeviceAll();
  }

  @override
  Future<FutureOr> onDispose() async {
    await disconnectDeviceAll();
  }
}
