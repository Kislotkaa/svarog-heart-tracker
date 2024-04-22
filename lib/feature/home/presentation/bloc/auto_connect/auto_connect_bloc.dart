import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/core/utils/service/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/feature/new_devices/domain/usecases/get_users_usecase.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'auto_connect_event.dart';
part 'auto_connect_state.dart';

class AutoConnectBloc extends Bloc<AutoConnectEvent, AutoConnectState> {
  /// **[NoParams]** required
  final GetUsersUseCase getUsersUseCase;

  final AppBluetoothService appBluetoothService;
  AutoConnectBloc({
    required this.getUsersUseCase,
    required this.appBluetoothService,
  }) : super(const AutoConnectState.initial()) {
    on<AutoConnectInitialEvent>(
      (event, emit) async {
        try {
          emit(
            state.copyWith(
              status: StateStatus.loading,
              errorMessage: null,
              errorTitle: null,
            ),
          );

          final failurOrUsers = await getUsersUseCase(NoParams());
          failurOrUsers.fold(
            (l) {},
            (users) {
              emit(
                state.copyWith(
                  status: StateStatus.success,
                  users: users,
                ),
              );
            },
          );
        } catch (e, s) {
          ErrorHandler.getMessage(e, s);
        }
      },
    );

    on<AutoConnectDisposeEvent>(
      (event, emit) async {
        try {
          appBluetoothService.stopScanDevice();
        } catch (e, s) {
          ErrorHandler.getMessage(e, s);
        }
      },
    );

    on<AutoConnectConnectEvent>((event, emit) {
      sl<ConnectDeviceBloc>().add(ConnectDeviceConnectEvent(device: event.blueDevice, name: event.name));
    });
    on<AutoConnectSetScanResultEvent>((event, emit) {
      emit(
        state.copyWith(
          scanResult: event.scanResult,
        ),
      );
    });
  }
}
