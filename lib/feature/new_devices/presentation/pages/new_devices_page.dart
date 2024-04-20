import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_cap_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_circular_progress_indicator_widget.dart';
import 'package:svarog_heart_tracker/core/utils/service/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/new_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/widgets/base_list_new_device_widget.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class NewDevicesPage extends StatefulWidget {
  const NewDevicesPage({Key? key}) : super(key: key);

  @override
  State<NewDevicesPage> createState() => _NewDevicesPageState();
}

class _NewDevicesPageState extends State<NewDevicesPage> {
  @override
  void initState() {
    sl<NewDeviceBloc>().add(const NewDeviceScanEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarWidget(
        title: 'Новые устройства',
        actions: [
          GestureDetector(
            onTap: () => sl<NewDeviceBloc>().add(const NewDeviceScanEvent()),
            child: const Icon(
              Icons.refresh_rounded,
            ),
          )
        ],
        needClose: true,
      ),
      body: BlocBuilder<NewDeviceBloc, NewDeviceState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: sl<AppBluetoothService>().scanResulStream,
                      builder: (context, snapshot) {
                        if (snapshot.data?.isNotEmpty == true) {
                          return Expanded(
                            child: BaseListNewDeviceWidget(
                              connectOrDisconnect: (BluetoothDevice device) => sl<NewDeviceBloc>().add(
                                NewDeviceConnectOrDisconnectEvent(device: device),
                              ),
                              haveConnect: (BluetoothDevice device) => haveConnect(state, device),
                              scanResult: sl<AppBluetoothService>().scanResult,
                              isPreviouslyConnected: (String id) => isPreviouslyConnected(state, id),
                              getName: (String id) => getNamePreviouslyDevice(state, id),
                            ),
                          );
                        }
                        return BaseCapWidget(
                          title: 'Список доступных устройст пуст.',
                          caption: 'Как подключить устройство?',
                          textLink: 'Жмак!',
                          icon: Icons.help_outline_rounded,
                          onRefresh: () {
                            sl<NewDeviceBloc>().add(const NewDeviceRefreshEvent());
                          },
                          onTap: () async {
                            router.push(const HowToUseRoute());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: sl<AppBluetoothService>().isScanning,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return const Align(
                      alignment: Alignment.bottomCenter,
                      child: BaseLinearProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  bool haveConnect(NewDeviceState state, BluetoothDevice blueDevice) {
    var result = sl<AppBluetoothService>().connectedDevices.firstWhereOrNull(
          (element) => blueDevice.remoteId.str == element.blueDevice.remoteId.str,
        );
    if (result == null) return false;
    return true;
  }

  bool isPreviouslyConnected(NewDeviceState state, String? id) {
    if (id != null) {
      return sl<AppBluetoothService>().previouslyConnected.firstWhereOrNull((element) => element.id == id) == null
          ? false
          : true;
    }
    return false;
  }

  String getNamePreviouslyDevice(NewDeviceState state, String? id) {
    if (id != null) {
      var result = sl<AppBluetoothService>().previouslyConnected.firstWhereOrNull((element) => element.id == id);
      return result?.personName ?? 'Empty';
    }
    return 'Empty';
  }
}
