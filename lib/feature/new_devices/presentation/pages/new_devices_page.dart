import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/feature/new_devices/data/new_device_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_cap_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/loading/base_linear_progress_indicator.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/confirm_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/previously_connected/previously_connected_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/scan_device/scan_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/choose_name_dialog_page.dart';
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

  @override
  void initState() {
    initScanDevice();
    sl<PreviouslyConnectedBloc>().add(const PreviouslyConnectedGetUsersEvent());
    super.initState();
  }

  @override
  void dispose() {
    disposeScanDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanDeviceBloc, ScanDeviceState>(
        buildWhen: (prev, next) => prev.scanResult.length != next.scanResult.length,
        builder: (context, scanDeviceState) {
          return Scaffold(
            appBar: BaseAppBarWidget(
              title: scanDeviceState.textStatus,
              needClose: true,
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    BlocBuilder<ConnectedDeviceBloc, ConnectedDeviceState>(
                      buildWhen: (prev, next) => prev.connectedDevices.length != next.connectedDevices.length,
                      builder: (context, connectedState) {
                        return BlocBuilder<PreviouslyConnectedBloc, PreviouslyConnectedState>(
                          buildWhen: (prev, next) => prev.previouslyConnected.length != next.previouslyConnected.length,
                          builder: (context, previuyslState) {
                            if (scanDeviceState.scanResult.isEmpty == false) {
                              return Expanded(
                                child: BaseListNewDeviceWidget(
                                  connectOrDisconnect: (BluetoothDevice device) {
                                    var result = connectedState.connectedDevices.firstWhereOrNull(
                                        (element) => element.blueDevice.remoteId.str == device.remoteId.str);
                                    if (result != null) {
                                      showConfirmDialog(
                                        context: context,
                                        title: 'Разорвать соединение?',
                                        description: 'Вы действительно хотите разорвать соединение?',
                                        onTapConfirm: () {
                                          router.removeLast();
                                          sl<ConnectDeviceBloc>().add(ConnectDeviceDisconnectEvent(blueDevice: device));
                                        },
                                        onTapCancel: () => Navigator.pop(context),
                                        textConfirm: 'Подтвердить',
                                        textCancel: 'Отмена',
                                      );
                                    } else {
                                      if (isPreviouslyConnected(
                                          previuyslState.previouslyConnected, device.remoteId.str)) {
                                        final name = getUserModelPreviouslyDevice(
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
                                              router.removeLast();

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
                                      getUserModelPreviouslyDevice(previuyslState.previouslyConnected, id),
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
                    ),
                  ],
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
        });
  }

  bool haveConnect(List<NewDeviceModel> connectedDevices, BluetoothDevice blueDevice) {
    late NewDeviceModel? result = connectedDevices.firstWhereOrNull(
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

  String getUserModelPreviouslyDevice(List<UserModel> previouslyConnected, String? id) {
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

      for (var element in result) {
        String? deviceName = element.advertisementData.advName;
        String? deviceNumber = element.device.remoteId.str;
        var model = NewDeviceModel(
          blueDevice: element.device,
          deviceId: deviceNumber,
          deviceName: deviceName,
          deviceNumber: deviceNumber.toString(),
        );

        scanResult.add(model);
        final textStatus = 'Список доступных: ${result.length}';

        scanDeviceBloc.add(
          ScanDeviceSetScanResultEvent(
            scanResult: scanResult,
            textStatus: textStatus,
          ),
        );
      }
    });
  }

  void disposeScanDevice() {
    final scanDeviceBloc = sl<ScanDeviceBloc>();
    subscriptionScanDevice?.cancel();
    scanDeviceBloc.add(const ScanDeviceDisposeEvent());
  }
}
