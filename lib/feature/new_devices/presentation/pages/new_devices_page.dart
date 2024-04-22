import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/new_device_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_cap_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_circular_progress_indicator_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_confirm_dialog_widget.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/previously_connected/previously_connected_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/scan_device/scan_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/widgets/base_choose_name_dialog_widget.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/widgets/base_list_new_device_widget.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class NewDevicesPage extends StatefulWidget {
  const NewDevicesPage({Key? key}) : super(key: key);

  @override
  State<NewDevicesPage> createState() => _NewDevicesPageState();
}

class _NewDevicesPageState extends State<NewDevicesPage> {
  late StreamSubscription<dynamic>? subscriptionScanDevice;
  late StreamSubscription<dynamic>? subscriptionConnected;

  @override
  void initState() {
    initScanDevice();
    initConnectedDevice();
    sl<PreviouslyConnectedBloc>().add(const PreviouslyConnectedGetUsersEvent());
    super.initState();
  }

  @override
  void dispose() {
    disposeScanDevice();
    disposeConnectedDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBarWidget(
        title: 'Новые устройства',
        needClose: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                BlocBuilder<ConnectedDeviceBloc, ConnectedDeviceState>(
                  // buildWhen: (prev, next) => true,
                  builder: (context, connectedState) {
                    return BlocBuilder<PreviouslyConnectedBloc, PreviouslyConnectedState>(
                      // buildWhen: (prev, next) => true,
                      builder: (context, previuyslState) {
                        return BlocBuilder<ScanDeviceBloc, ScanDeviceState>(
                          // buildWhen: (prev, next) => true,
                          builder: (context, scanDeviceState) {
                            if (scanDeviceState.scanResult.isEmpty == false) {
                              return Expanded(
                                child: BaseListNewDeviceWidget(
                                  connectOrDisconnect: (BluetoothDevice device) {
                                    var result = sl<ConnectedDeviceBloc>().state.connectedDevices.firstWhereOrNull(
                                        (element) => element.blueDevice.remoteId.str == device.remoteId.str);
                                    if (result != null) {
                                      showConfirmDialog(
                                        context: context,
                                        title: 'Разорвать соединение?',
                                        text: 'Вы действительно хотите разорвать соединение?',
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          sl<ConnectDeviceBloc>().add(ConnectDeviceDisconnectEvent(device: device));
                                        },
                                        onTapCancel: () => Navigator.pop(context),
                                        textConfirm: 'Подтвердить',
                                        textCancel: 'Отмена',
                                      );
                                    } else {
                                      if (isPreviouslyConnected(
                                          previuyslState.previouslyConnected, device.remoteId.str)) {
                                        final name = getNamePreviouslyDevice(
                                            previuyslState.previouslyConnected, device.remoteId.str);
                                        sl<ConnectDeviceBloc>()
                                            .add(ConnectDeviceConnectEvent(device: device, name: name));
                                      } else {
                                        TextEditingController controller = TextEditingController();

                                        showChooseNameDialog(
                                          context: context,
                                          title: 'Кто это?',
                                          controller: controller,
                                          onTapConfirm: () async {
                                            if (controller.text.isNotEmpty) {
                                              Navigator.pop(context);
                                              sl<ConnectDeviceBloc>().add(
                                                  ConnectDeviceConnectEvent(device: device, name: controller.text));
                                            }
                                          },
                                          onTapCancel: () => Navigator.pop(context),
                                          textConfirm: 'Подтвердить',
                                          textCancel: 'Отмена',
                                        );
                                      }
                                    }
                                  },
                                  haveConnect: (BluetoothDevice device) => haveConnect(
                                    connectedState.connectedDevices,
                                    device,
                                  ),
                                  scanResult: scanDeviceState.scanResult,
                                  isPreviouslyConnected: (String id) =>
                                      isPreviouslyConnected(previuyslState.previouslyConnected, id),
                                  getName: (String id) =>
                                      getNamePreviouslyDevice(previuyslState.previouslyConnected, id),
                                ),
                              );
                            }
                            return BaseCapWidget(
                              title: 'Список доступных устройст пуст.',
                              caption: 'Как подключить устройство?',
                              textLink: 'Жмак!',
                              icon: Icons.help_outline_rounded,
                              onTap: () async {
                                router.push(const HowToUseRoute());
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<ScanDeviceBloc, ScanDeviceState>(
            buildWhen: (prev, next) => prev.status != next.status,
            builder: (context, state) {
              if (state.status == StateStatus.loading) {
                return const Align(
                  alignment: Alignment.bottomCenter,
                  child: BaseLinearProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }

  bool haveConnect(List<NewDeviceModel> connectedDevices, BluetoothDevice blueDevice) {
    var result = connectedDevices.firstWhereOrNull(
      (element) => blueDevice.remoteId.str == element.blueDevice.remoteId.str,
    );
    if (result == null) return false;
    return true;
  }

  bool isPreviouslyConnected(List<UserModel> previouslyConnected, String? id) {
    if (id != null) {
      return previouslyConnected.firstWhereOrNull((element) => element.id == id) == null ? false : true;
    }
    return false;
  }

  String getNamePreviouslyDevice(List<UserModel> previouslyConnected, String? id) {
    if (id != null) {
      var result = previouslyConnected.firstWhereOrNull((element) => element.id == id);
      return result?.personName ?? 'Empty';
    }
    return 'Empty';
  }

  void initScanDevice() {
    final scanDeviceBloc = sl<ScanDeviceBloc>();
    scanDeviceBloc.add(const ScanDeviceInitialEvent());

    subscriptionScanDevice = Stream.periodic(const Duration(seconds: 1)).listen((event) {
      var result = scanDeviceBloc.appBluetoothService.scanResult;

      late List<NewDeviceModel> scanResult = [];

      final filtered = result.where((element) =>
          element.advertisementData.serviceUuids
              .firstWhereOrNull((element) => (element.str.toLowerCase()).contains('180d')) !=
          null);

      for (var element in filtered) {
        String? deviceName = element.advertisementData.advName;
        String? deviceNumber = element.device.remoteId.str;
        var model = NewDeviceModel(
          blueDevice: element.device,
          deviceId: deviceNumber,
          deviceName: deviceName,
          deviceNumber: deviceNumber.toString(),
        );

        scanResult.add(model);
        final textStatus = 'Список доступных устройств: ${filtered.length}';

        print(textStatus);

        scanDeviceBloc.add(
          ScanDeviceSetScanResultEvent(
            scanResult: scanResult,
            textStatus: textStatus,
          ),
        );
      }
    });
  }

  void initConnectedDevice() {
    final connectDeviceBloc = sl<ConnectedDeviceBloc>();
    connectDeviceBloc.add(const ConnectedDeviceInitialEvent());

    subscriptionConnected = Stream.periodic(const Duration(seconds: 1)).listen((event) async {
      var list = await connectDeviceBloc.appBluetoothService.getConnectedDevices();
      late List<NewDeviceModel> connectedDevices = [];

      for (var element in list) {
        var model = NewDeviceModel(
          blueDevice: element,
          deviceId: '',
          deviceName: '',
          deviceNumber: '',
        );
        connectedDevices.add(model);
        connectDeviceBloc.add(ConnectedDeviceSetScanResultEvent(connectedDevices: connectedDevices));
      }
    });
  }

  void disposeScanDevice() {
    final scanDeviceBloc = sl<ScanDeviceBloc>();
    subscriptionScanDevice?.cancel();
    scanDeviceBloc.add(const ScanDeviceDisposeEvent());
  }

  void disposeConnectedDevice() {
    final connectedDeviceBloc = sl<ConnectedDeviceBloc>();
    subscriptionConnected?.cancel();
    connectedDeviceBloc.add(const ConnectedDeviceDisposeEvent());
  }
}
