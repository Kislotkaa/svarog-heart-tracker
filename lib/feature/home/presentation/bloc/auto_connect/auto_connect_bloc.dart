import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';
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
    on<AutoConnectDisposeEvent>(
      (event, emit) async {
        try {
          appBluetoothService.stopScanDevice();
        } catch (e, s) {
          ErrorHandler.getMessage(e, s);
        }
      },
    );

    on<AutoConnectSetScanResultEvent>((event, emit) async {
      final failurOrUsers = await getUsersUseCase(NoParams());
      failurOrUsers.fold(
        (l) {
          state.copyWith(
            status: StateStatus.failure,
            errorTitle: 'Ошибка',
            errorMessage: l.data?.message,
          );
        },
        (users) {
          for (var element in event.scanResult) {
            var result = users.firstWhereOrNull(
              (elementConnected) => elementConnected.id == element.device.remoteId.str,
            );
            if (result != null && result.isAutoConnect == true) {
              sl<ConnectDeviceBloc>().add(ConnectDeviceConnectEvent(device: element.device, name: result.personName));
            }
          }

          emit(
            state.copyWith(
              status: StateStatus.success,
            ),
          );
        },
      );
    });
  }
}
