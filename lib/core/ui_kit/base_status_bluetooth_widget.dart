import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';

class BaseStatusBluetoothWidget extends StatefulWidget {
  const BaseStatusBluetoothWidget({
    super.key,
  });

  @override
  State<BaseStatusBluetoothWidget> createState() => _BaseStatusBluetoothWidgetState();
}

class _BaseStatusBluetoothWidgetState extends State<BaseStatusBluetoothWidget> {
  get bluetoothController => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<BluetoothAdapterState>(
          stream: FlutterBluePlus.adapterState,
          initialData: BluetoothAdapterState.unknown,
          builder: (stateContext, snapshotState) {
            return StreamBuilder<bool>(
              stream: FlutterBluePlus.isScanning,
              initialData: false,
              builder: (isScanningContext, snapshotScanning) {
                final state = snapshotState.data;
                final isScanning = snapshotScanning.data;
                final connectedList = FlutterBluePlus.connectedDevices;

                late Widget iconStatus = const Icon(Icons.bluetooth_rounded);
                switch (state) {
                  case BluetoothAdapterState.on:
                    if (isScanning == true) {
                      iconStatus = getSearchingBluetooth();
                    } else if (connectedList.isNotEmpty) {
                      iconStatus = getConnectedBluetooth();
                    } else {
                      iconStatus = getDefaultBluetooth();
                    }
                    break;

                  case BluetoothAdapterState.off:
                    iconStatus = getDisabledBluetooth();
                    break;

                  case BluetoothAdapterState.unavailable:
                    iconStatus = getEmptyBluetooth();
                    break;

                  case BluetoothAdapterState.unauthorized:
                    iconStatus = getPermissionBluetooth();
                    break;

                  case BluetoothAdapterState.turningOn:
                    iconStatus = getDefaultBluetooth();
                    break;
                  case BluetoothAdapterState.turningOff:
                    iconStatus = getDefaultBluetooth();
                    break;

                  case BluetoothAdapterState.unknown:
                    iconStatus = getEmptyBluetooth();
                    break;

                  default:
                    iconStatus = getDisabledBluetooth();
                    break;
                }
                return iconStatus;
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
        AppSnackbar.showTextFloatingSnackBar(
          title: 'Статус: Выключен',
          description: 'Bluetooth модуль устройства выключен',
          overlayState: Overlay.of(context),
          status: SnackStatusEnum.access,
        );
      },
      child: Icon(
        Icons.bluetooth_disabled_rounded,
        color: appTheme.errorColor,
      ),
    );
  }

  Widget getEmptyBluetooth() {
    return GestureDetector(
      onTap: () {
        AppSnackbar.showTextFloatingSnackBar(
          title: 'Ошибка',
          description: 'Устройство Bluetooth не обнаружено',
          overlayState: Overlay.of(context),
          status: SnackStatusEnum.error,
        );
      },
      child: Icon(
        Icons.bluetooth_disabled_rounded,
        color: appTheme.textColor.withOpacity(0.3),
      ),
    );
  }

  Widget getPermissionBluetooth() {
    return GestureDetector(
      onTap: () {
        AppSnackbar.showTextFloatingSnackBar(
          title: 'Ошибка доступа',
          description: 'Устройство не получило доступ к Bluetooth',
          overlayState: Overlay.of(context),
          status: SnackStatusEnum.error,
        );
      },
      child: Icon(
        Icons.bluetooth_disabled_rounded,
        color: appTheme.yellowColor,
      ),
    );
  }

  Widget getConnectedBluetooth() {
    return GestureDetector(
      onTap: () {
        AppSnackbar.showTextFloatingSnackBar(
          title: 'Статус: Активно',
          description: 'В данный момент Bluetooth используется',
          overlayState: Overlay.of(context),
          status: SnackStatusEnum.access,
        );
      },
      child: const Icon(Icons.bluetooth_connected),
    );
  }

  Widget getDefaultBluetooth() {
    return GestureDetector(
      onTap: () {
        AppSnackbar.showTextFloatingSnackBar(
          title: 'Статус: Включен',
          description: 'Модуль Bluetooth включён но не используется',
          overlayState: Overlay.of(context),
          status: SnackStatusEnum.access,
        );
      },
      child: const Icon(Icons.bluetooth_rounded),
    );
  }

  Widget getSearchingBluetooth() {
    return GestureDetector(
      onTap: () {
        AppSnackbar.showTextFloatingSnackBar(
          title: 'Статус: Поисп',
          description: 'Модуль Bluetooth ищет устройства побблизости',
          overlayState: Overlay.of(context),
          status: SnackStatusEnum.access,
        );
      },
      child: const Icon(Icons.bluetooth_searching_rounded),
    );
  }
}
