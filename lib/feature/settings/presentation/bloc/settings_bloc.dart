import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/start_app/clear_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/start_app/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/start_app/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/clear_database_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// **[NoParams]** required
  final ClearCacheStartAppUseCase clearCacheStartAppUseCase;

  /// **[StartAppModel]** required
  final SetCacheStartAppUseCase setCacheStartAppUseCase;

  /// **[NoParams]** required
  final GetCacheStartAppUseCase getCacheStartAppUseCase;

  /// **[NoParams]** required
  final ClearDatabaseUseCase clearAllDatabaseUseCase;
  SettingsBloc({
    required this.clearCacheStartAppUseCase,
    required this.setCacheStartAppUseCase,
    required this.getCacheStartAppUseCase,
    required this.clearAllDatabaseUseCase,
  }) : super(const SettingsState.initial()) {
    on<SettingsDeleteAccountEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );
        final failurOrSuccess = await clearCacheStartAppUseCase(NoParams());
        failurOrSuccess.fold(
          (l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorMessage: l.data?.message,
                errorTitle: 'Ошибка',
              ),
            );
          },
          (success) {
            emit(
              state.copyWith(
                status: StateStatus.success,
              ),
            );

            router.pushAndPopUntil(const AuthAdminRoute(), predicate: (_) => false);
          },
        );
      },
    );
    on<SettingsDeleteHistoryEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );
        final failurOrSuccess = await clearAllDatabaseUseCase(NoParams());
        failurOrSuccess.fold((l) {}, (success) {});
        emit(
          state.copyWith(
            status: StateStatus.success,
            errorMessage: null,
            errorTitle: null,
          ),
        );
      },
    );
    on<SettingsLogoutEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );
        final failurOrStartApp = await getCacheStartAppUseCase(NoParams());
        failurOrStartApp.fold(
          (l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                errorMessage: l.data?.message,
                errorTitle: 'Ошибка',
              ),
            );
          },
          (startAppModel) async {
            if (startAppModel != null) {
              var param = startAppModel.copyWith(isHaveAuth: false);
              final failurOrSuccess = await setCacheStartAppUseCase(param);
              failurOrSuccess.fold(
                (l) {
                  emit(
                    state.copyWith(
                      status: StateStatus.failure,
                      errorMessage: l.data?.message,
                      errorTitle: 'Ошибка',
                    ),
                  );
                },
                (r) {},
              );
              router.pushAndPopUntil(const AuthRoute(), predicate: (_) => false);
            } else {
              final failurOrSuccess = await clearCacheStartAppUseCase(NoParams());
              failurOrSuccess.fold(
                (l) {
                  emit(
                    state.copyWith(
                      status: StateStatus.failure,
                      errorMessage: l.data?.message,
                      errorTitle: 'Ошибка',
                    ),
                  );
                },
                (success) {
                  emit(
                    state.copyWith(
                      status: StateStatus.success,
                    ),
                  );
                  router.pushAndPopUntil(const AuthAdminRoute(), predicate: (_) => false);
                },
              );
            }
          },
        );
      },
    );
  }
}
