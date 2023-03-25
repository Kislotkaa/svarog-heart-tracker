import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../models/new_device_model.dart';
import 'base_checker.dart';

class BaseNewDevice extends StatelessWidget {
  const BaseNewDevice({
    super.key,
    required this.connectOrDisconnect,
    required this.device,
    required this.name,
    required this.number,
    required this.haveConnect,
  });

  final Function(BluetoothDevice device) connectOrDisconnect;
  final NewDeviceModel device;
  final String name;
  final String number;

  final Function(BluetoothDevice device) haveConnect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => connectOrDisconnect(
              device.blueDevice,
            ),
        child: Row(
          children: [
            BaseChecker(
              isActive: haveConnect(
                device.blueDevice,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 6),
                Text(
                  number,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            )
          ],
        ).paddingOnly(bottom: 16));
  }
}
