import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/app.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/l10n/generated/l10n.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/start_app/get_cache_start_app_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  /// **[NoParams]** required
  final GetCacheStartAppUseCase getCacheStartAppUserCase;

  SplashBloc({required this.getCacheStartAppUserCase}) : super(const SplashState.initial()) {
    on<SplashInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorTitle: null,
          errorMessage: null,
        ),
      );
      await Future.delayed(const Duration(seconds: 1));

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
          emit(
            state.copyWith(
              status: StateStatus.success,
            ),
          );

          if (startApp == null || startApp.isFirstStart == true) {
            router.pushAndPopUntil(const AuthAdminRoute(), predicate: (_) => false);
            return;
          }

          startApp.isHaveAuth
              ? router.pushAndPopUntil(const HomeRoute(), predicate: (_) => false)
              : router.pushAndPopUntil(const AuthRoute(), predicate: (_) => false);
        },
      );
    });
  }
}
