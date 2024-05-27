import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/remove_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/remove_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/remove_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  /// **[NoParams]** required
  final GetUsersUseCase getUsersUseCase;

  /// **[String]** required
  final GetUserByPkUseCase getUserByPkUseCase;

  /// **[String]** required
  final RemoveUserByPkUseCase removeUserByPkUseCase;

  /// **[String]** required
  final RemoveUserDetailByPkUseCase removeUserDetailByPkUseCase;

  /// **[String]** required
  final RemoveUserSettingsByPkUseCase removeUserSettingsByPkUseCase;

  // /// **[String]** required
  // final RemoveUserHistoryByPkUseCase removeUserHistoryByPkUseCase;

  HistoryBloc({
    required this.getUsersUseCase,
    required this.removeUserByPkUseCase,
    required this.removeUserDetailByPkUseCase,
    required this.removeUserSettingsByPkUseCase,
    required this.getUserByPkUseCase,
  }) : super(const HistoryState.initial()) {
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

      final failurOrUser = await getUserByPkUseCase(event.id);
      UserModel? user;
      failurOrUser.fold((l) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorTitle: 'Ошибка',
            errorMessage: l.data?.message,
          ),
        );
        return;
      }, (userReturned) {
        user = userReturned;
      });

      final failurOrRemovedUser = await removeUserByPkUseCase(event.id);

      failurOrRemovedUser.fold(
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
        (removedUser) {
          List<UserModel> users = state.users;
          users.removeWhere((element) => element.id == event.id);
          emit(state.copyWith(
            status: StateStatus.success,
            users: users,
          ));
        },
      );

      if (user?.userDetailId != null) {
        await removeUserDetailByPkUseCase(user!.userDetailId!);
      }

      if (user?.userSettingsId != null) {
        await removeUserSettingsByPkUseCase(user!.userSettingsId!);
      }
    });
  }
}
