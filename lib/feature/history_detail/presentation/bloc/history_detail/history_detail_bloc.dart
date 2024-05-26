import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/update_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/get_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/remove_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/tflite/usecase/get_tflite_callory_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'history_detail_event.dart';
part 'history_detail_state.dart';

class HistoryDetailBloc extends Bloc<HistoryDetailEvent, HistoryDetailState> {
  /// **[String]** required
  final GetUserByPkUseCase getUserByPkUseCase;

  /// **[GetUserHistoryParams]** required
  final GetUserDetailByPkUseCase getUserDetailByPkUseCase;

  /// **[GetUserHistoryParams]** required
  final GetUserHistoryUserByPkUseCase getUserHistoryUserByPkUseCase;

  /// **[String]** required
  final RemoveUserHistoryByPkUseCase deleteUserHistoryByPkUseCase;

  /// **[UserParams]** required
  final UpdateUserByPkUseCase updateUserUseCase;

  /// **[UserParams]** required
  final InsertUserHistoryUseCase insertUserHistoryUseCase;

  /// **[UserParams]** required
  final GetTFLiteCalloryUseCase getTFLiteCalloryUseCase;

  HistoryDetailBloc({
    required this.updateUserUseCase,
    required this.getUserByPkUseCase,
    required this.getUserDetailByPkUseCase,
    required this.insertUserHistoryUseCase,
    required this.getUserHistoryUserByPkUseCase,
    required this.deleteUserHistoryByPkUseCase,
    required this.getTFLiteCalloryUseCase,
  }) : super(const HistoryDetailState.initial()) {
    on<HistoryDetailInitialEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        pagination: HivePagination(),
        listHistory: [],
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrUser = await getUserByPkUseCase(event.userId);

      UserModel? user;
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
        (userReturned) => user = userReturned,
      );

      final failurOrDetail = await getUserDetailByPkUseCase(user?.userDetailId ?? '');
      UserDetailModel? detail;
      failurOrDetail.fold(
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
        (detailReturned) => detail = detailReturned,
      );

      final failurOrHistory = await getUserHistoryUserByPkUseCase(GetUserHistoryParams(
        userId: event.userId,
        pagination: state.pagination,
      ));

      List<UserHistoryModel> listHistory = [];
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
        (historyReturned) => listHistory = historyReturned,
      );

      log(listHistory.length.toString());

      emit(state.copyWith(
        status: StateStatus.success,
        listHistory: listHistory,
        user: user,
        detail: detail,
      ));

      add(const HistoryDetailCalculateCalloryEvent());
    });

    on<HistoryDetailLoadMoreEvent>((event, emit) async {
      final userId = state.user?.id;
      HivePagination? pagination = state.pagination;

      if (userId == null || pagination == null || state.status == StateStatus.loadMore || pagination.isEnd) {
        return;
      }

      emit(state.copyWith(
        status: StateStatus.loadMore,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrHistory =
          await getUserHistoryUserByPkUseCase(GetUserHistoryParams(userId: userId, pagination: pagination));

      List<UserHistoryModel> listHistory = [];
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
        (historyResult) {
          for (var elementState in state.listHistory) {
            listHistory.removeWhere((element) => element.id == elementState.id);
          }
          listHistory = historyResult;
        },
      );

      emit(state.copyWith(
        listHistory: [...state.listHistory, ...listHistory],
        pagination: pagination.copyWith(
          page: pagination.page + 1,
          isEnd: listHistory.isEmpty,
        ),
      ));

      await Future.delayed(const Duration(milliseconds: 500));

      add(const HistoryDetailCalculateCalloryEvent());

      emit(state.copyWith(
        status: StateStatus.success,
      ));
    });

    on<HistoryDetailCalculateCalloryEvent>((event, emit) async {
      final detail = state.detail;
      final listHistory = state.listHistory;

      /// Если у пользователя не заполнена детальная инфа
      if (detail == null) {
        return;
      }

      /// Если история сейчас активно то не считаем
      final activeDevices = sl<HomeBloc>().state.list;
      for (var activedevice in activeDevices) {
        if (activedevice.id == state.user?.id) {
          return;
        }
      }

      emit(state.copyWith(
        status: StateStatus.loadMore,
        listHistory: listHistory,
      ));

      /// Предсказываем калории
      for (var history in listHistory) {
        /// Считаем только те каллории которых нет
        if (history.calories == null) {
          final filurOrHistoryModel = await getTFLiteCalloryUseCase(TFLiteParams(
            detail: detail,
            history: history,
          ));
          UserHistoryModel? elementHistory;
          filurOrHistoryModel.fold((l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorTitle: 'Ошибка',
                errorMessage: l.data?.message,
              ),
            );
            return;
          }, (historyWithCallory) {
            if (historyWithCallory == null) return;

            for (var i = 0; i < listHistory.length; i++) {
              if (listHistory[i].id == historyWithCallory.id) {
                listHistory[i] = listHistory[i].copyWith(calories: historyWithCallory.calories);
                elementHistory = listHistory[i];
              }
            }
          });

          filurOrHistoryModel.fold((l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorTitle: 'Ошибка',
                errorMessage: l.data?.message,
              ),
            );
            return;
          }, (historyWithCallory) {
            if (historyWithCallory == null) return;

            for (var i = 0; i < listHistory.length; i++) {
              if (listHistory[i].id == historyWithCallory.id) {
                listHistory[i] = listHistory[i].copyWith(calories: historyWithCallory.calories);
                elementHistory = listHistory[i];
              }
            }
          });

          if (elementHistory != null) {
            await insertUserHistoryUseCase(elementHistory!);
          }
        }
      }
      emit(state.copyWith(
        status: StateStatus.success,
        listHistory: listHistory,
      ));
    });

    on<HistoryDetailRefreshEvent>((event, emit) async {
      if (state.user == null || state.status == StateStatus.loadMore || state.status == StateStatus.loading) {
        return;
      }

      final pagination = HivePagination();

      emit(state.copyWith(
        status: StateStatus.loading,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrHistory = await getUserHistoryUserByPkUseCase(GetUserHistoryParams(
        userId: state.user!.id,
        pagination: pagination,
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
            pagination: pagination,
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
