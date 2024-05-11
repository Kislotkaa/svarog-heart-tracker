import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/intl_cubit.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/repository/intl_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/repository/theme_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/utils/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/sqllite_service.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/start_app/clear_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/settings_utils.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/datasourse/start_app_datasource.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/repository/start_app_repository.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/start_app/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/start_app/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth_admin/auth_admin_bloc.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/bloc/history_bloc.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user_history/delete_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user_history/get_user_history_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user/update_user_usecase.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/history_detail_bloc.dart';
import 'package:svarog_heart_tracker/core/utils/service/bluetooth/datasourse/bluetooth_datasource.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/datasourse/user_datasource.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/datasourse/user_history_datasource.dart';
import 'package:svarog_heart_tracker/core/utils/service/bluetooth/repository/bluetooth_repository.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/repository/user_history_repository.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/repository/user_repository.dart';
import 'package:svarog_heart_tracker/core/utils/service/bluetooth/usecase/get_connected_device_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user_history/get_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/auto_connect/auto_connect_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/user/get_users_usecase.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/previously_connected/previously_connected_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/scan_device/scan_device_bloc.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/usecase/clear_database_usecase.dart';
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
  sl.registerLazySingleton(() => GetUserHistoryByPkUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => GetUserByPkUseCase(sl()));
  sl.registerLazySingleton(() => InsertUserHistoryUseCase(sl()));
  sl.registerLazySingleton(() => InsertUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserHistoryUserByPkUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserHistoryByPkUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => ClearDatabaseUseCase(sl()));

  // --- Bloc --- \\
  sl.registerLazySingleton(() => AuthAdminBloc(setCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => AuthBloc(setCacheStartAppUserCase: sl(), getCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => SplashBloc(getCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => HomeBloc(getConnectedDeviceUseCase: sl(), appBluetoothService: sl()));
  sl.registerLazySingleton(() => ConnectedDeviceBloc(appBluetoothService: sl()));
  sl.registerLazySingleton(() => ConnectDeviceBloc(appBluetoothService: sl()));
  sl.registerLazySingleton(() => PreviouslyConnectedBloc(appBluetoothService: sl(), getUsersUserCase: sl()));
  sl.registerLazySingleton(() => ScanDeviceBloc(appBluetoothService: sl()));
  sl.registerLazySingleton(() => AutoConnectBloc(appBluetoothService: sl(), getUsersUseCase: sl()));
  sl.registerLazySingleton(() => HistoryBloc(getUsersUseCase: sl()));

  sl.registerLazySingleton(() => HistoryDetailBloc(
        getUserByPkUseCase: sl(),
        getUserHistoryUserByPkUseCase: sl(),
        deleteUserHistoryByPkUseCase: sl(),
        updateUserUseCase: sl(),
      ));

  sl.registerLazySingleton(() => SettingsBloc(
        clearCacheStartAppUseCase: sl(),
        setCacheStartAppUseCase: sl(),
        getCacheStartAppUseCase: sl(),
        clearAllDatabaseUseCase: sl(),
      ));

  // --- Other --- \\
  final sharedPreferences = await SharedPreferences.getInstance();
  final appBluetoothService = AppBluetoothService()..init();
  final sqlLiteService = SqlLiteService()..init();
  final hiveService = HiveService()..init();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => sqlLiteService);
  sl.registerLazySingleton(() => hiveService);
  sl.registerLazySingleton(() => appBluetoothService);
  sl.registerLazySingleton(() => SettingsUtils(sl()));
  sl.registerLazySingleton(() => AppRouter());
}
