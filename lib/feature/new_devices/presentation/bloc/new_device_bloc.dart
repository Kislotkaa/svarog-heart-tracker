import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/feature/new_devices/domain/usecases/get_users_usecase.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'new_device_event.dart';
part 'new_device_state.dart';

class NewDeviceBloc extends Bloc<NewDeviceEvent, NewDeviceState> {
  /// **[NoParams]** required
  final GetUsersUseCase getUsersUseCase;
  NewDeviceBloc({required this.getUsersUseCase}) : super(const NewDeviceState.initial()) {
    on<NewDeviceRefreshEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorTitle: null,
          errorMessage: null,
        ),
      );
    });
    on<NewDeviceScanEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorTitle: null,
          errorMessage: null,
        ),
      );

      final failurOrUsers = await getUsersUseCase(NoParams());

      failurOrUsers.fold(
        (l) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorMessage: l.data?.message,
              errorTitle: 'Ошибка',
            ),
          );
        },
        (users) async {
          sl<AppBluetoothService>().addpreviouslyConnected(users);
          sl<AppBluetoothService>().startScanDevice();

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
