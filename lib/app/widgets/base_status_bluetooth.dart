import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/app/controllers/base_snackbar_controller.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/resourse/app_colors.dart';

class BaseStatusBluetooth extends StatelessWidget {
  const BaseStatusBluetooth({
    super.key,
    required this.bluetoothController,
  });

  final BluetoothController bluetoothController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<BluetoothState>(
          stream: FlutterBluePlus.instance.state,
          initialData: BluetoothState.unknown,
          builder: (stateContext, snapshotState) {
            return StreamBuilder<bool>(
              stream: FlutterBluePlus.instance.isScanning,
              initialData: false,
              builder: (isScanningContext, snapshotScanning) {
                return FutureBuilder<List<BluetoothDevice>>(
                  future: FlutterBluePlus.instance.connectedDevices,
                  initialData: [],
                  builder: (connectedDevicesContext, snapshotConnected) {
                    final state = snapshotState.data;
                    final isScanning = snapshotScanning.data;
                    final connectedList = snapshotConnected.data ?? [];

                    late Widget iconStatus = Icon(Icons.bluetooth_rounded);
                    switch (state) {
                      case BluetoothState.on:
                        if (isScanning == true) {
                          iconStatus = getSearchingBluetooth();
                        } else if (connectedList.isNotEmpty) {
                          iconStatus = getConnectedBluetooth();
                        } else {
                          iconStatus = getDefaultBluetooth();
                        }
                        break;

                      case BluetoothState.off:
                        iconStatus = getDisabledBluetooth();
                        break;

                      case BluetoothState.turningOn:
                        iconStatus = getDefaultBluetooth();
                        break;

                      default:
                        iconStatus = getDisabledBluetooth();
                        break;
                    }
                    return iconStatus;
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget getDisabledBluetooth() {
    return GestureDetector(
      onTap: () {
        bluetoothController.getDisabledSnackBar();
      },
      child: Icon(
        Icons.bluetooth_disabled_rounded,
        color: AppColors.redConst,
      ),
    );
  }

  Widget getConnectedBluetooth() {
    return GestureDetector(
      onTap: () {
        showSnackbar(
          'В данный момент модуль Bluetooth используется',
          'Статус: Используется',
          status: SnackStatusEnum.access,
        );
      },
      child: Icon(Icons.bluetooth_connected),
    );
  }

  Widget getDefaultBluetooth() {
    return GestureDetector(
      onTap: () {
        showSnackbar(
          'Модуль Bluetooth включён но не используется',
          'Статус: Включён',
          status: SnackStatusEnum.access,
        );
      },
      child: Icon(Icons.bluetooth_rounded),
    );
  }

  Widget getSearchingBluetooth() {
    return GestureDetector(
      onTap: () {
        showSnackbar(
          'Модуль Bluetooth ищет устройства побблизости',
          'Статус: Поиск',
          status: SnackStatusEnum.access,
        );
      },
      child: Icon(Icons.bluetooth_searching_rounded),
    );
  }
}
