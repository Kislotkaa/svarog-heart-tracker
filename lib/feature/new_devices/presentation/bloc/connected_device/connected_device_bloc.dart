import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/feature/new_devices/data/new_device_model.dart';
import 'package:svarog_heart_tracker/core/utils/service/bluetooth/app_bluetooth_service.dart';

part 'connected_device_event.dart';
part 'connected_device_state.dart';

class ConnectedDeviceBloc extends Bloc<ConnectedDeviceEvent, ConnectedDeviceState> {
  final AppBluetoothService appBluetoothService;
  ConnectedDeviceBloc({required this.appBluetoothService}) : super(const ConnectedDeviceState.initial()) {
    on<ConnectedDeviceInitialEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
        ),
      );
    });
    on<ConnectedDeviceDisposeEvent>((event, emit) {});
    on<ConnectedDeviceSetScanResultEvent>((event, emit) {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          connectedDevices: event.connectedDevices,
        ),
      );
    });
  }
}
