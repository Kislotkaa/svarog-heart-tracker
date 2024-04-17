import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// **[NoParams]** required
  final GetCacheStartAppUseCase getCacheStartAppUserCase;

  /// **[StartAppModel]** required
  final SetCacheStartAppUseCase setCacheStartAppUserCase;

  AuthBloc({required this.setCacheStartAppUserCase, required this.getCacheStartAppUserCase})
      : super(const AuthState.initial()) {
    on<AuthSingInEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
          ),
        );

        final failureOrStartApp = await getCacheStartAppUserCase(NoParams());
        failureOrStartApp.fold(
          (l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorTitle: 'Ошибка',
                errorMessage: 'Произошла какая то ошибка, повторите попытку позже',
              ),
            );
          },
          (startApp) async {
            if (startApp == null || startApp.localPassword == null) {
              sl<AppRouter>().pushAndPopUntil(const AuthAdminRoute(), predicate: (Route<dynamic> route) => false);

              return;
            }
            if (startApp.localPassword != event.password) {
              state.copyWith(
                status: StateStatus.notValid,
                errorTitle: 'Пароль не верный',
                errorMessage: 'Не верный пароль, проверьте правильность ввода и повторите попытку',
              );
            }
            var param = startApp.copyWith(isHaveAuth: true);
            final failureOrStartApp = await setCacheStartAppUserCase(param);
            failureOrStartApp.fold(
              (l) {
                emit(
                  state.copyWith(
                    status: StateStatus.failure,
                    errorTitle: 'Ошибка',
                    errorMessage: 'Произошла какая то ошибка, повторите попытку позже',
                  ),
                );
              },
              (startApp) {
                sl<AppRouter>().pushAndPopUntil(const HomeRoute(), predicate: (Route<dynamic> route) => false);
              },
            );
          },
        );
      },
    );
    on<AuthLogOutEvent>(
      (event, emit) async {},
    );
  }
}
