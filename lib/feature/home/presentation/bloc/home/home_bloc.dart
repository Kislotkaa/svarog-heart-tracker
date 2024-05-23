import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/usecase/get_connected_device_usecase.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// **[NoParams]** required
  final GetConnectedDeviceUseCase getConnectedDeviceUseCase;

  final AppBluetoothService appBluetoothService;
  HomeBloc({
    required this.getConnectedDeviceUseCase,
    required this.appBluetoothService,
  }) : super(const HomeState.initial()) {
    on<HomeInitialEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );

        var failureOrDevices = await getConnectedDeviceUseCase(NoParams());
        failureOrDevices.fold(
          (l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorTitle: 'Ошибка',
                errorMessage: l.data?.message,
              ),
            );
            return;
          },
          (list) {
            late List<DeviceController> resultList = [];

            for (var elementState in state.list) {
              final BluetoothDevice? elementList = list.firstWhereOrNull(
                (elementList) => elementList.remoteId.str == elementState.device.remoteId.str,
              );

              if (elementList != null) resultList.add(elementState);
            }

            emit(
              state.copyWith(
                status: StateStatus.success,
                list: resultList,
              ),
            );
          },
        );
      },
    );

    on<HomeAddDeviceControllerEvent>(
      (event, emit) {
        try {
          final isNotHave = state.list.firstWhereOrNull((element) => element.id == event.deviceController.id) == null;

          if (isNotHave) {
            event.deviceController.onInit();

            emit(
              state.copyWith(
                status: StateStatus.success,
                list: [...state.list, event.deviceController],
              ),
            );
          }
        } catch (e, s) {
          ErrorHandler.getMessage(e, s);
        }
      },
    );

    on<HomeRemoveDeviceEvent>((event, emit) async {
      try {
        DeviceController? deviceController =
            state.list.firstWhereOrNull((element) => event.blueDevice.remoteId.str == element.device.remoteId.str);

        if (deviceController != null) deviceController.onDispose();

        List<DeviceController> list = [...state.list]
          ..removeWhere((element) => event.blueDevice.remoteId.str == element.device.remoteId.str);

        emit(
          state.copyWith(
            status: StateStatus.success,
            list: list,
          ),
        );
      } catch (e, s) {
        ErrorHandler.getMessage(e, s);
      }
    });

    on<HomeRefreshEvent>((event, emit) {
      add(const HomeInitialEvent());
    });
  }
}
