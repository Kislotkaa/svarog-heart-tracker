import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';

part 'previously_connected_event.dart';
part 'previously_connected_state.dart';

class PreviouslyConnectedBloc extends Bloc<PreviouslyConnectedEvent, PreviouslyConnectedState> {
  /// **[NoParams]** required
  final GetUsersUseCase getUsersUserCase;

  final AppBluetoothService appBluetoothService;
  PreviouslyConnectedBloc({required this.appBluetoothService, required this.getUsersUserCase})
      : super(const PreviouslyConnectedState.initial()) {
    on<PreviouslyConnectedGetUsersEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorMessage: null,
          errorTitle: null,
        ),
      );
      final failurOrUsers = await getUsersUserCase(NoParams());
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
        (users) {
          emit(
            state.copyWith(
              status: StateStatus.success,
              previouslyConnected: users,
            ),
          );
        },
      );
    });
  }
}
