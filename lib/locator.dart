import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/intl_cubit.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/repository/intl_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/repository/theme_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/utils/service/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/core/utils/service/database_service/sqllite_service.dart';
import 'package:svarog_heart_tracker/core/utils/settings_utils.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/datasource/start_app_datasource.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/repository/start_app_repository.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/usecases/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth_admin/auth_admin_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/domain/datasource/bluetooth_datasource.dart';
import 'package:svarog_heart_tracker/feature/home/domain/datasource/user_datasource.dart';
import 'package:svarog_heart_tracker/feature/home/domain/datasource/user_history_datasource.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/bluetooth_repository.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_history_repository.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_repository.dart';
import 'package:svarog_heart_tracker/feature/home/domain/usecases/get_connected_device_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/usecases/get_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/usecases/insert_history_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/usecases/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/domain/usecases/get_users_usecase.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/new_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/settings/domain/usecases/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/settings_bloc.dart';
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
  sl.registerLazySingleton<UserDataSource>(
    () => UserDataSourceImpl(
      sqlLiteService: sl(),
    ),
  );
  sl.registerLazySingleton<UserHistoryDataSource>(
    () => UserHistoryDataSourceImpl(
      sqlLiteService: sl(),
    ),
  );
  sl.registerLazySingleton<BluetoothDataSource>(
    () => BluetoothDataSourceImpl(
      bluetoothService: sl(),
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

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      userDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<UserHistoryRepository>(
    () => UserHistoryRepositoryImpl(
      userHistoryDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<BluetoothRepository>(
    () => BluetoothRepositoryImpl(
      bluetoothDataSource: sl(),
    ),
  );

  // --- UseCase --- \\
  sl.registerLazySingleton(() => SetCacheStartAppUseCase(sl()));
  sl.registerLazySingleton(() => GetCacheStartAppUseCase(sl()));
  sl.registerLazySingleton(() => ClearCacheStartAppUseCase(sl()));
  sl.registerLazySingleton(() => GetConnectedDeviceUseCase(sl()));
  sl.registerLazySingleton(() => GetHistoryByPkUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => InsertHistoryUseCase(sl()));
  sl.registerLazySingleton(() => InsertUserUseCase(sl()));

  // --- Bloc --- \\
  sl.registerLazySingleton(() => AuthAdminBloc(setCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => AuthBloc(setCacheStartAppUserCase: sl(), getCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => SplashBloc(getCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => HomeBloc(getConnectedDeviceUseCase: sl()));
  sl.registerLazySingleton(() => NewDeviceBloc(getUsersUseCase: sl()));

  sl.registerLazySingleton(() => SettingsBloc(
        clearCacheStartAppUseCase: sl(),
        setCacheStartAppUseCase: sl(),
        getCacheStartAppUseCase: sl(),
      ));

  // --- Other --- \\
  final sharedPreferences = await SharedPreferences.getInstance();
  final appBluetoothService = AppBluetoothService()..initial();
  final sqlLiteService = SqlLiteService()..init();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => sqlLiteService);
  sl.registerLazySingleton(() => appBluetoothService);
  sl.registerLazySingleton(() => SettingsUtils(sl()));
  sl.registerLazySingleton(() => AppRouter());
}
