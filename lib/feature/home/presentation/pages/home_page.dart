import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/common/assets.gen.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_status_bluetooth_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/loading/base_linear_progress_indicator.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/confirm_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/auto_connect/auto_connect_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/widgets/base_grid_people.dart';
import 'package:svarog_heart_tracker/feature/new_devices/data/new_device_model.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription<dynamic>? subscriptionConnected;
  late StreamSubscription<dynamic>? subscriptioAutoConneect;

  @override
  void initState() {
    sl<HomeBloc>().add(const HomeInitialEvent());
    initConnectedDevice();
    initialAutoConnectSubscribe();
    super.initState();
  }

  @override
  void dispose() {
    disposeConnectedDevice();
    disposeAutoConnectSubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBarWidget(
        title: 'Сварог',
        leadingWidget: Hero(
          tag: 'appIcon.svg',
          child: GestureDetector(
            onTap: () => router.push(const SettingsRoute()),
            child: Assets.icons.appIcon.svg(height: 36),
          ),
        ),
        actions: const [BaseStatusBluetoothWidget()],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (prev, next) => prev.list.length != next.list.length,
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                child: Center(
                  child: Assets.images.backGroundLogo.image(),
                ),
              ),
              Stack(
                children: [
                  BaseGridPeople(
                    list: state.list,
                    onRemove: (device) {
                      showConfirmDialog(
                        context: context,
                        onTapConfirm: () async {
                          router.removeLast();
                          sl<ConnectDeviceBloc>().add(ConnectDeviceDisconnectEvent(deviceController: device));
                        },
                        onTapCancel: () => router.removeLast(),
                        textConfirm: 'Подтвердить',
                        textCancel: 'Отмена',
                        title: 'Разорвать соединение?',
                        description: 'Вы действительно хотите разорвать соединение?',
                      );
                    },
                    onRefresh: () {
                      sl<HomeBloc>().add(const HomeRefreshEvent());
                    },
                  ),
                ],
              ),
              if (state.status == StateStatus.loading)
                const Align(alignment: Alignment.bottomCenter, child: BaseLinearProgressIndicator()),
            ],
          );
        },
      ),
    );
  }

  void disposeAutoConnectSubscribe() {
    subscriptioAutoConneect?.cancel();
    sl<AutoConnectBloc>().add(const AutoConnectDisposeEvent());
  }

  void initialAutoConnectSubscribe() {
    final authoConnectBloc = sl<AutoConnectBloc>();
    final timeCheckDevice = sl<GlobalSettingsService>().appSettings.timeCheckDevice.toInt();
    subscriptioAutoConneect = Stream.periodic(Duration(seconds: timeCheckDevice)).listen((event) async {
      authoConnectBloc.appBluetoothService.startScanDevice(duration: const Duration(seconds: 2));
      authoConnectBloc.add(AutoConnectSetScanResultEvent(authoConnectBloc.appBluetoothService.scanResult));
    });
  }

  void initConnectedDevice() {
    final connectedDeviceBloc = sl<ConnectedDeviceBloc>();
    connectedDeviceBloc.add(const ConnectedDeviceInitialEvent());

    subscriptionConnected = Stream.periodic(const Duration(seconds: 1)).listen((event) async {
      var list = await connectedDeviceBloc.appBluetoothService.getConnectedDevices();
      late List<NewDeviceModel> connectedDevices = [];

      for (var element in list) {
        final deviceName = element.advName;
        final deviceNumber = element.remoteId.str;
        var model = NewDeviceModel(
          blueDevice: element,
          deviceId: deviceNumber,
          deviceName: deviceName,
          deviceNumber: deviceNumber.toString(),
        );
        connectedDevices.add(model);
      }
      connectedDeviceBloc.add(ConnectedDeviceSetScanResultEvent(connectedDevices: connectedDevices));
    });
  }

  void disposeConnectedDevice() {
    subscriptionConnected?.cancel();
    sl<ConnectedDeviceBloc>().add(const ConnectedDeviceDisposeEvent());
  }
}
