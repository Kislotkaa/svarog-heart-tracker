import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:svarog_heart_tracker/core/models/new_device_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';

class AppBluetoothService extends Disposable {
  Stream<List<ScanResult>> get scanResulStream => FlutterBluePlus.scanResults;
  Stream<bool> get isScanning => FlutterBluePlus.isScanning;
  Future<bool> get isSupported async => await FlutterBluePlus.isSupported;

  late List<UserModel> previouslyConnected;
  late List<NewDeviceModel> scanResult = [];
  late List<NewDeviceModel> connectedDevices = [];

  Future<void> startScanDevice({int scanSeconds = 3}) async {
    if (!FlutterBluePlus.isScanningNow) {
      scanResult.clear();
      connectedDevices.clear();
      previouslyConnected.clear();

      await FlutterBluePlus.startScan(
        androidScanMode: AndroidScanMode.lowPower,
        timeout: Duration(seconds: scanSeconds),
      );
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

  void _listenScanResult() {
    scanResulStream.listen((event) {
      var result = event.where((element) =>
          element.advertisementData.serviceUuids
              .firstWhereOrNull((element) => (element.str.toLowerCase()).contains('180d')) !=
          null);

      scanResult.clear();

      for (var element in result) {
        final deviceName = element.advertisementData.advName;
        final deviceNumber = element.device.remoteId.str;

        scanResult.add(
          NewDeviceModel(
            blueDevice: element.device,
            deviceId: deviceNumber,
            deviceName: deviceName,
            deviceNumber: deviceNumber.toString(),
          ),
        );
      }
    });
  }

  void _subscribeConnectedDevices() async {
    Stream.periodic(const Duration(seconds: 1)).listen((event) async {
      var list = await getConnectedDevices();
      connectedDevices.clear();

      for (var element in list) {
        var model = NewDeviceModel(
          blueDevice: element,
          deviceId: '',
          deviceName: '',
          deviceNumber: '',
        );
        connectedDevices.add(model);
      }
    });
  }

  Future<void> initial() async {
    _subscribeConnectedDevices();
    _listenScanResult();
    await disconnectDeviceAll();
  }

  @override
  Future<FutureOr> onDispose() async {
    await disconnectDeviceAll();
  }

  void addpreviouslyConnected(List<UserModel> users) {
    previouslyConnected = users;
  }
}
