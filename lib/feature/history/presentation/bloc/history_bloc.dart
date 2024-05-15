import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  /// **[NoParams]** required
  final GetUsersUseCase getUsersUseCase;

  HistoryBloc({required this.getUsersUseCase}) : super(const HistoryState.initial()) {
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
  }
}
