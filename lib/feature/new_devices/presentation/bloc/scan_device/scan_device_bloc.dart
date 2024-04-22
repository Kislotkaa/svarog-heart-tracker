import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/new_device_model.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/core/utils/service/app_bluetooth_service.dart';

part 'scan_device_event.dart';
part 'scan_device_state.dart';

class ScanDeviceBloc extends Bloc<ScanDeviceEvent, ScanDeviceState> {
  final AppBluetoothService appBluetoothService;
  ScanDeviceBloc({required this.appBluetoothService}) : super(const ScanDeviceState.initial()) {
    on<ScanDeviceInitialEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            textStatus: 'Поиск свободных устройств...',
            scanResult: [],
          ),
        );
      } catch (e, s) {
        ErrorHandler.getMessage(e, s);
      }
    });

    on<ScanDeviceSetScanResultEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          textStatus: event.textStatus,
          scanResult: event.scanResult,
        ),
      );
    });

    on<ScanDeviceDisposeEvent>((event, emit) async {});
  }
}
