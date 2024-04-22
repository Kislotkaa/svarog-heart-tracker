import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/auto_connect/auto_connect_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class AutoConnectPage extends StatefulWidget {
  const AutoConnectPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<AutoConnectPage> createState() => _AutoConnectPageState();
}

class _AutoConnectPageState extends State<AutoConnectPage> {
  final Stream stream = Stream.periodic(const Duration(seconds: 6));
  late StreamSubscription subscriptionScanDevice;
  @override
  void initState() {
    initialSubscribe();
    super.initState();
  }

  @override
  void dispose() {
    disposeSubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoConnectBloc, AutoConnectState>(
      buildWhen: (prev, next) =>
          prev.users.length != next.users.length || prev.scanResult.length != next.scanResult.length,
      builder: (context, autoConnectState) {
        // ignore: avoid_function_literals_in_foreach_calls
        autoConnectState.scanResult.forEach((elementDevice) async {
          var result = autoConnectState.users
              .firstWhereOrNull((elementConnected) => elementConnected.id == elementDevice.device.remoteId.str);
          print(result);
          if (result != null && result.isAutoConnect == true) {
            sl<AutoConnectBloc>().add(AutoConnectConnectEvent(elementDevice.device, result.personName));
          }
        });
        return widget.child;
      },
    );
  }

  void disposeSubscribe() {
    subscriptionScanDevice.cancel();
    sl<AutoConnectBloc>().add(const AutoConnectDisposeEvent());
  }

  void initialSubscribe() {
    final authoConnectBloc = sl<AutoConnectBloc>();
    authoConnectBloc.add(const AutoConnectInitialEvent());

    subscriptionScanDevice = Stream.periodic(const Duration(seconds: 6)).listen((event) async {
      authoConnectBloc.appBluetoothService.startScanDevice(duration: const Duration(seconds: 2));
      var scanResult = authoConnectBloc.appBluetoothService.scanResult;

      print(scanResult);

      authoConnectBloc.add(AutoConnectSetScanResultEvent(scanResult));
    });
  }
}
