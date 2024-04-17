import 'package:svarog_heart_tracker/core/cubit/intl_cubit/intl_cubit.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/repository/intl_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/repository/theme_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/utils/settings_utils.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/datasource/start_app_datasource.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/repository/start_app_repository.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth/auth_bloc.dart';

import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth_admin/auth_admin_bloc.dart';
import 'package:svarog_heart_tracker/feature/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --- Cubit --- \\
  sl.registerLazySingleton(
    () => ThemeCubit(themeRepository: sl()),
  );
  sl.registerLazySingleton(
    () => IntlCubit(intlRepository: sl()),
  );
  // --- DataSource --- \\
  sl.registerLazySingleton<StartAppDataSource>(
    () => StartAppDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // --- Repositories --- \\
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<IntlRepository>(
    () => IntlRepositoryImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<StartAppRepository>(
    () => StartAppRepositoryImpl(
      startAppDataSource: sl(),
    ),
  );

  // --- UseCase --- \\
  sl.registerLazySingleton(() => SetCacheStartAppUseCase(sl()));
  sl.registerLazySingleton(() => GetCacheStartAppUseCase(sl()));

  // --- Bloc --- \\
  sl.registerLazySingleton(() => AuthAdminBloc(setCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => AuthBloc(setCacheStartAppUserCase: sl(), getCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => SplashBloc(getCacheStartAppUserCase: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  final appRouter = AppRouter();

  sl.registerLazySingleton(() => SettingsUtils(sl()));
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => appRouter);
}
