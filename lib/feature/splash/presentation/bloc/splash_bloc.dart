import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/get_cache_start_app_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  /// **[StartAppModel]** required
  final GetCacheStartAppUseCase getCacheStartAppUserCase;

  SplashBloc({required this.getCacheStartAppUserCase}) : super(const SplashState.initial()) {
    on<SplashInitEvent>(
      (event, emit) async {},
    );
  }
}
