import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/feature/history_detail/domain/usecases/delete_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/feature/history_detail/domain/usecases/get_user_history_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/feature/history_detail/domain/usecases/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/history_detail/domain/usecases/update_user_use_case.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

part 'history_detail_event.dart';
part 'history_detail_state.dart';

class HistoryDetailBloc extends Bloc<HistoryDetailEvent, HistoryDetailState> {
  /// **[String]** required
  final GetUserByPkUseCase getUserByPkUseCase;

  /// **[String]** required
  final GetUserHistoryUserByPkUseCase getUserHistoryUserByPkUseCase;

  /// **[String]** required
  final DeleteUserHistoryByPkUseCase deleteUserHistoryByPkUseCase;

  /// **[UserParams]** required
  final UpdateUserUseCase updateUserUseCase;

  HistoryDetailBloc({
    required this.updateUserUseCase,
    required this.getUserByPkUseCase,
    required this.getUserHistoryUserByPkUseCase,
    required this.deleteUserHistoryByPkUseCase,
  }) : super(const HistoryDetailState.initial()) {
    on<HistoryDetailInitialEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        deviceController: event.deviceController,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrUser = await getUserByPkUseCase(event.userId);

      failurOrUser.fold(
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
        (user) {
          emit(state.copyWith(
            status: StateStatus.success,
            user: user,
          ));
        },
      );

      final failurOrHistory = await getUserHistoryUserByPkUseCase(event.userId);

      failurOrHistory.fold(
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
        (history) {
          emit(state.copyWith(
            status: StateStatus.success,
            listHistory: history,
          ));
        },
      );
    });
    on<HistoryDetailGetHistoryEvent>((event, emit) async {
      if (state.user == null) {
        return;
      }

      final failurOrHistory = await getUserHistoryUserByPkUseCase(state.user!.id);

      failurOrHistory.fold(
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
        (history) {
          emit(state.copyWith(
            status: StateStatus.success,
            listHistory: history,
          ));
        },
      );
    });

    on<HistoryDetailDeleteAllEvent>((event, emit) async {
      for (var element in state.listHistory) {
        await deleteUserHistoryByPkUseCase(element.id);
      }
      emit(state.copyWith(
        status: StateStatus.success,
        listHistory: [],
      ));
    });
    on<HistoryDetailDeleteEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrHistory = await deleteUserHistoryByPkUseCase(event.id);

      failurOrHistory.fold(
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
        (history) {
          emit(state.copyWith(
            status: StateStatus.success,
          ));
          add(const HistoryDetailGetHistoryEvent());
        },
      );
    });
    on<HistoryDetailSwitchAutoConnectEvent>((event, emit) async {
      if (state.user == null) {
        return;
      }

      var model = UserParams(
        id: state.user!.id,
        personName: state.user!.personName,
        deviceName: state.user!.deviceName,
        isAutoConnect: !(state.user!.isAutoConnect ?? false),
      );

      final failurOrSuccess = await updateUserUseCase(model);

      failurOrSuccess.fold((l) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorTitle: 'Ошибка',
            errorMessage: l.data?.message,
          ),
        );
      }, (user) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            user: user,
          ),
        );
      });
    });
  }
}
