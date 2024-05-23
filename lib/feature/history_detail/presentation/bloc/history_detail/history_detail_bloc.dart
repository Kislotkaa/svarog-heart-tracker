import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/update_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/remove_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

part 'history_detail_event.dart';
part 'history_detail_state.dart';

class HistoryDetailBloc extends Bloc<HistoryDetailEvent, HistoryDetailState> {
  /// **[String]** required
  final GetUserByPkUseCase getUserByPkUseCase;

  /// **[GetUserHistoryParams]** required
  final GetUserHistoryUserByPkUseCase getUserHistoryUserByPkUseCase;

  /// **[String]** required
  final RemoveUserHistoryByPkUseCase deleteUserHistoryByPkUseCase;

  /// **[UserParams]** required
  final UpdateUserByPkUseCase updateUserUseCase;

  HistoryDetailBloc({
    required this.updateUserUseCase,
    required this.getUserByPkUseCase,
    required this.getUserHistoryUserByPkUseCase,
    required this.deleteUserHistoryByPkUseCase,
  }) : super(const HistoryDetailState.initial()) {
    on<HistoryDetailInitialEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        pagination: HivePagination(),
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
          emit(
            state.copyWith(
              status: StateStatus.success,
              user: user,
            ),
          );
        },
      );

      final failurOrHistory = await getUserHistoryUserByPkUseCase(GetUserHistoryParams(
        userId: event.userId,
        pagination: state.pagination,
      ));

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

    on<HistoryDetailLoadMoreEvent>((event, emit) async {
      final userId = state.user?.id;
      HivePagination? pagination = state.pagination;
      if (userId == null || pagination == null || state.status == StateStatus.loadMore) {
        return;
      }

      emit(state.copyWith(
        status: StateStatus.loadMore,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrHistory =
          await getUserHistoryUserByPkUseCase(GetUserHistoryParams(userId: userId, pagination: pagination));

      List<UserHistoryModel> history = [];
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
        (historyResult) async {
          history = historyResult;
          for (var elementState in state.listHistory) {
            history.removeWhere((element) => element.id == elementState.id);
          }
        },
      );

      emit(state.copyWith(
        listHistory: [...state.listHistory, ...history],
        pagination: pagination.copyWith(page: pagination.page + 1),
      ));

      await Future.delayed(const Duration(milliseconds: 300));

      emit(state.copyWith(
        status: StateStatus.success,
      ));
    });

    on<HistoryDetailRefreshEvent>((event, emit) async {
      if (state.user == null || state.status == StateStatus.loadMore || state.status == StateStatus.loading) {
        return;
      }
      emit(state.copyWith(
        status: StateStatus.loading,
        listHistory: [],
        pagination: HivePagination(),
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrHistory = await getUserHistoryUserByPkUseCase(GetUserHistoryParams(
        userId: state.user!.id,
        pagination: state.pagination,
      ));

      await Future.delayed(const Duration(milliseconds: 300));

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

    on<HistoryDetailGetUserEvent>((event, emit) async {
      if (state.user == null) {
        return;
      }

      final failurOrHistory = await getUserByPkUseCase(state.user!.id);

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
        (user) {
          emit(state.copyWith(
            status: StateStatus.success,
            user: user,
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
          List<UserHistoryModel> listHistoryResult = state.listHistory;
          listHistoryResult.removeWhere((element) => element.id == event.id);
          emit(state.copyWith(
            listHistory: listHistoryResult,
            status: StateStatus.success,
          ));
        },
      );
    });

    on<HistoryDetailSwitchAutoConnectEvent>((event, emit) async {
      if (state.user == null) {
        return;
      }

      var model = UserParams(
        id: state.user!.id,
        userDetailId: state.user!.userDetailId,
        userSettingsId: state.user!.userSettingsId,
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
