import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/usecases/get_connected_device_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// **[NoParams]** required
  final GetConnectedDeviceUseCase getConnectedDeviceUseCase;
  HomeBloc({required this.getConnectedDeviceUseCase}) : super(const HomeState.initial()) {
    on<HomeInitialEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );

        final failureOrDevices = await getConnectedDeviceUseCase(NoParams());
        failureOrDevices.fold(
          (l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorTitle: 'Ошибка',
                errorMessage: l.data?.message,
              ),
            );
          },
          (list) {
            List<DeviceController> stateList = state.list;

            stateList.removeWhere(
              (elementList) =>
                  list.firstWhereOrNull((element) => element.remoteId.str == elementList.device.remoteId.str) == null,
            );

            emit(
              state.copyWith(
                status: StateStatus.success,
                list: stateList,
              ),
            );
          },
        );
      },
    );
  }
}
