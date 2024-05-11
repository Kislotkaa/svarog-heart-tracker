import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/core/utils/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'connect_device_event.dart';
part 'connect_device_state.dart';

class ConnectDeviceBloc extends Bloc<ConnectDeviceEvent, ConnectDeviceState> {
  final AppBluetoothService appBluetoothService;
  ConnectDeviceBloc({required this.appBluetoothService}) : super(const ConnectDeviceState.initial()) {
    on<ConnectDeviceDisconnectEvent>((event, emit) async {
      try {
        if (event.blueDevice == null && event.deviceController == null) {
          return;
        }
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorTitle: null,
            errorMessage: null,
          ),
        );
        if (event.blueDevice != null) {
          await appBluetoothService.disconnectDevice(event.blueDevice!);
          sl<HomeBloc>().add(HomeRemoveDeviceEvent(blueDevice: event.blueDevice!));
        } else {
          await appBluetoothService.disconnectDevice(event.deviceController!.device);
          sl<HomeBloc>().add(HomeRemoveDeviceEvent(blueDevice: event.deviceController!.device));
        }

        emit(
          state.copyWith(
            status: StateStatus.success,
          ),
        );
      } catch (e, s) {
        ErrorHandler.getMessage(e, s);
      }
    });

    on<ConnectDeviceConnectEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorTitle: null,
            errorMessage: null,
          ),
        );

        await appBluetoothService.connectToDevice(event.device);
        DeviceController deviceController = DeviceController(
          id: event.device.remoteId.str,
          device: event.device,
          name: event.name,
          getHistoryByPkUseCase: sl(),
          insertHistoryUseCase: sl(),
          insertUserUseCase: sl(),
          getUserByPkUseCase: sl(),
        );
        sl<HomeBloc>().add(HomeAddDeviceControllerEvent(deviceController: deviceController));
        emit(
          state.copyWith(
            status: StateStatus.success,
          ),
        );
      } catch (e, s) {
        ErrorHandler.getMessage(e, s);
      }
    });
  }
}
