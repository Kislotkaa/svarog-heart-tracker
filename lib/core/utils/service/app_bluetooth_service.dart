import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppBluetoothService {
  Stream<List<ScanResult>> get scanResulStream => FlutterBluePlus.scanResults;
  Stream<bool> get isScanning => FlutterBluePlus.isScanning;
  Future<bool> get isSupported async => await FlutterBluePlus.isSupported;
  List<ScanResult> get scanResult => FlutterBluePlus.lastScanResults;

  Future<void> startScanDevice({Duration? duration}) async {
    if (!FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.startScan(
        withServices: [Guid('180d')],
        androidScanMode: AndroidScanMode.lowPower,
        timeout: duration,
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
    await blueDevice.connect(autoConnect: false);
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

  Future<void> init() async {
    await disconnectDeviceAll();
  }
}
