import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BaseStatusBluetooth extends StatelessWidget {
  const BaseStatusBluetooth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<BluetoothState>(
            stream: FlutterBluePlus.instance.state,
            initialData: BluetoothState.unknown,
            builder: (c, snapshot) {
              final state = snapshot.data;
              late String textStatus = '';
              switch (state) {
                case BluetoothState.on:
                  textStatus = 'Блютуз активен';
                  break;

                case BluetoothState.off:
                  textStatus = 'Блютуз выключен';
                  break;

                case BluetoothState.turningOff:
                  textStatus = 'Блютуз выключается';
                  break;

                case BluetoothState.turningOn:
                  textStatus = 'Блютуз включается';
                  break;

                case BluetoothState.unauthorized:
                  textStatus = 'Блютуз ошибка доступа';
                  break;

                case BluetoothState.unavailable:
                  textStatus = 'Блютуз недоступен';
                  break;

                case BluetoothState.unknown:
                  textStatus = 'Блютуз неизвестный';
                  break;

                default:
                  textStatus = '';
                  break;
              }
              return Text(textStatus);
            }),
      ],
    );
  }
}
