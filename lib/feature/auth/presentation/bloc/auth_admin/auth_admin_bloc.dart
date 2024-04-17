import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:svarog_heart_tracker/core/config/env.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'auth_admin_event.dart';
part 'auth_admin_state.dart';

class AuthAdminBloc extends Bloc<AuthAdminEvent, AuthAdminState> {
  /// **[StartAppModel]** required
  final SetCacheStartAppUseCase setCacheStartAppUserCase;

  AuthAdminBloc({required this.setCacheStartAppUserCase}) : super(const AuthAdminState.initial()) {
    on<AuthSingInAdminEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
          ),
        );
        if (event.password == EnvironmentConfig.APP_PASSWORD) {
          emit(
            state.copyWith(
              status: StateStatus.success,
              crossFadeState: CrossFadeState.showSecond,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: StateStatus.notValid,
              errorMessage: 'Обратитесь к администратору за паролем',
              errorTitle: 'Пароли не совпадают',
            ),
          );
        }
      },
    );
    on<AuthSetPasswordAdminEvent>(
      (event, emit) async {
        state.copyWith(
          status: StateStatus.loading,
        );
        if (event.password != event.repeatPassword) {
          emit(
            state.copyWith(
              status: StateStatus.notValid,
              errorMessage: 'Проверьте правильность ввода паролей и повторите попытку',
              errorTitle: 'Пароли не совпадают',
            ),
          );
          return;
        }
        if (event.password.isEmpty) {
          emit(
            state.copyWith(
              status: StateStatus.notValid,
              errorMessage: 'Пароль должен быть минимум один символ',
              errorTitle: 'Пустых паролей не бывает',
            ),
          );
          return;
        }
        var param = StartAppModel(
          isFirstStart: false,
          isHaveAuth: false,
          localPassword: event.password,
        );
        final failureOrStartApp = await setCacheStartAppUserCase(param);
        failureOrStartApp.fold(
          (l) {
            state.copyWith(
              status: StateStatus.failure,
              errorTitle: 'Ошибка',
              errorMessage: 'Произошла какая то ошибка, повторите попытку позже',
            );
          },
          (startApp) {
            sl<AppRouter>().pushAndPopUntil(const AuthRoute(), predicate: (Route<dynamic> route) => false);
          },
        );
      },
    );
  }
}
