import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/feature/new_devices/data/new_device_model.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/widgets/base_new_device_widget.dart';

class BaseListNewDeviceWidget extends StatelessWidget {
  const BaseListNewDeviceWidget({
    super.key,
    required this.scanResult,
    required this.isPreviouslyConnected,
    required this.haveConnect,
    required this.getName,
    required this.connectOrDisconnect,
  });

  final List<NewDeviceModel> scanResult;
  final bool Function(BluetoothDevice device) haveConnect;
  final Function(String id) isPreviouslyConnected;
  final Function(String id) getName;
  final Function(BluetoothDevice device) connectOrDisconnect;

  @override
  Widget build(BuildContext context) {
    List<Widget> oldDevice = [];
    List<Widget> newDevice = [];

    for (var element in scanResult) {
      if (isPreviouslyConnected(element.deviceId)) {
        oldDevice.add(
          BaseNewDeviceWidget(
            connectOrDisconnect: connectOrDisconnect,
            device: element,
            haveConnect: haveConnect,
            name: getName(element.deviceId),
            number: element.deviceNumber,
          ),
        );
      } else {
        newDevice.add(
          BaseNewDeviceWidget(
            connectOrDisconnect: connectOrDisconnect,
            device: element,
            haveConnect: haveConnect,
            name: element.deviceName,
            number: element.deviceNumber,
          ),
        );
      }
    }
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: 100,
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newDevice.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Новые',
                        style: appTheme.textTheme.buttonExtrabold16,
                      ),
                      const SizedBox(height: 16),
                      Column(children: newDevice),
                    ],
                  )
                : const SizedBox(),
            oldDevice.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ранее подключенные',
                        style: appTheme.textTheme.buttonExtrabold16,
                      ),
                      const SizedBox(height: 16),
                      Column(children: oldDevice),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
