import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/remove_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/remove_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  /// **[NoParams]** required
  final GetUsersUseCase getUsersUseCase;

  /// **[String]** required
  final RemoveUserByPkUseCase removeUserByPkUseCase;

  /// **[String]** required
  final RemoveUserHistoryByPkUseCase removeUserHistoryByPkUseCase;

  HistoryBloc(
      {required this.getUsersUseCase, required this.removeUserByPkUseCase, required this.removeUserHistoryByPkUseCase})
      : super(const HistoryState.initial()) {
    on<HistoryInitialEvent>((event, emit) async {
      add(const GetHistoryEvent());
    });

    on<GetHistoryEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrUsers = await getUsersUseCase(NoParams());

      failurOrUsers.fold(
        (l) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorTitle: 'Ошибка',
              errorMessage: l.data?.message,
            ),
          );
        },
        (users) {
          emit(state.copyWith(
            status: StateStatus.success,
            users: users,
          ));
        },
      );
    });

    on<DeleteHistoryEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrUsers = await removeUserByPkUseCase(event.id);

      failurOrUsers.fold(
        (l) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorTitle: 'Ошибка',
              errorMessage: l.data?.message,
            ),
          );
        },
        (users) {
          List<UserModel> users = state.users;
          users.removeWhere((element) => element.id == event.id);

          emit(state.copyWith(
            status: StateStatus.success,
            users: users,
          ));
        },
      );
    });
  }
}
