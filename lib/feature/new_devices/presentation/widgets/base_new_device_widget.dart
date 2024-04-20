import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/models/new_device_model.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_checker_widget.dart';

class BaseNewDeviceWidget extends StatelessWidget {
  const BaseNewDeviceWidget({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => connectOrDisconnect(
          device.blueDevice,
        ),
        child: Row(
          children: [
            BaseCheckerWidget(
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
                  style: appTheme.textTheme.bodySemibold16,
                ),
                const SizedBox(height: 6),
                Text(
                  number,
                  style: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.textGrayColor),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BaseChecker {}
