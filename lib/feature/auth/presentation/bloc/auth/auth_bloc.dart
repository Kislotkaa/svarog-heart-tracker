import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:svarog_heart_tracker/app.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/l10n/generated/l10n.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/start_app/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/start_app/set_cache_start_app_usecase.dart';
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
            errorMessage: null,
            errorTitle: null,
          ),
        );

        final failureOrStartApp = await getCacheStartAppUserCase(NoParams());
        failureOrStartApp.fold(
          (l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorTitle: S.of(externalContext).error,
                errorMessage: S.of(externalContext).somethingWrong,
              ),
            );
          },
          (startApp) async {
            if (startApp == null || startApp.localPassword == null) {
              sl<AppRouter>().pushAndPopUntil(const AuthAdminRoute(), predicate: (Route<dynamic> route) => false);

              return;
            }
            if (startApp.localPassword != event.password) {
              emit(
                state.copyWith(
                  status: StateStatus.notValid,
                  errorTitle: 'Пароль не верный',
                  errorMessage: 'Не верный пароль, проверьте правильность ввода и повторите попытку',
                ),
              );
              return;
            }
            var param = startApp.copyWith(isHaveAuth: true);
            final failureOrStartApp = await setCacheStartAppUserCase(param);
            failureOrStartApp.fold(
              (l) {
                emit(
                  state.copyWith(
                    status: StateStatus.failure,
                    errorTitle: S.of(externalContext).error,
                    errorMessage: S.of(externalContext).somethingWrong,
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
