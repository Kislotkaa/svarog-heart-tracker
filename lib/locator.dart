import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/intl_cubit.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/repository/intl_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/repository/theme_repository.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/app_notification_service.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_detail_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_history_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_settings_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_detail_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/sqllite_service.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/clear_all_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/clear_all_user_detail.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/get_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/insert_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/update_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/clear_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/update_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/clear_all_user_settings.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/get_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/insert_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/update_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/start_app/usecase/clear_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/remove_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/tflite/detasource/user_settings_datasource.dart';
import 'package:svarog_heart_tracker/core/service/tflite/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/service/tflite/tflite_service.dart';
import 'package:svarog_heart_tracker/core/service/tflite/usecase/get_tflite_callory_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/settings_utils.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/start_app/datasource/start_app_datasource.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/start_app/repository/start_app_repository.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/start_app/usecase/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/start_app/usecase/set_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth_admin/auth_admin_bloc.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/bloc/history_bloc.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/remove_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/update_user_usecase.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/history_detail/history_detail_bloc.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/datasourse/bluetooth_datasource.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/repository/bluetooth_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_history_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/usecase/get_connected_device_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/user_edit_detail/user_edit_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/auto_connect/auto_connect_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/previously_connected/previously_connected_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/scan_device/scan_device_bloc.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/clear_database_usecase.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/global_settings/global_settings_bloc.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/settings/settings_bloc.dart';
import 'package:svarog_heart_tracker/feature/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // Global Settings
  final sharedPreferences = await SharedPreferences.getInstance();
  final globalSettingsService = GlobalSettingsService(sharedPreferences: sharedPreferences).init();
  await registerHiveOrSqlModules(globalSettingsService);

  // --- Cubit --- \\
  sl.registerLazySingleton(() => ThemeCubit(themeRepository: sl()));
  sl.registerLazySingleton(() => IntlCubit(intlRepository: sl()));
  // --- DataSource --- \\
  sl.registerLazySingleton<StartAppDataSource>(
    () => StartAppDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<UserSettingsDataSource>(
    () => UserSettingsDataSourceHiveImpl(hiveService: sl()),
  );
  sl.registerLazySingleton<UserDetailDataSource>(
    () => UserDetailDataSourceHiveImpl(hiveService: sl()),
  );
  sl.registerLazySingleton<TFLiteDataSource>(
    () => TFLiteDataSourceImpl(tfLiteService: sl()),
  );
  sl.registerLazySingleton<BluetoothDataSource>(
    () => BluetoothDataSourceImpl(bluetoothService: sl()),
  );

  // --- Repositories --- \\
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<IntlRepository>(
    () => IntlRepositoryImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<StartAppRepository>(
    () => StartAppRepositoryImpl(startAppDataSource: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userDataSource: sl()),
  );
  sl.registerLazySingleton<UserHistoryRepository>(
    () => UserHistoryRepositoryImpl(userHistoryDataSource: sl()),
  );
  sl.registerLazySingleton<UserSettingsRepository>(
    () => UserSettingsRepositoryImpl(userSettingsDataSource: sl()),
  );
  sl.registerLazySingleton<UserDetailRepository>(
    () => UserDetailRepositoryImpl(userDetailDataSource: sl()),
  );
  sl.registerLazySingleton<BluetoothRepository>(
    () => BluetoothRepositoryImpl(bluetoothDataSource: sl()),
  );
  sl.registerLazySingleton<TFLiteRepository>(
    () => TFLiteRepositoryImpl(tfLiteDataSource: sl()),
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
  sl.registerLazySingleton(() => RemoveUserHistoryByPkUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserByPkUseCase(sl()));
  sl.registerLazySingleton(() => ClearAllUserHistoryUseCase(sl()));
  sl.registerLazySingleton(() => RemoveUserByPkUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserSettingsByPkUseCase(sl()));
  sl.registerLazySingleton(() => InsertUserSettingsByPkUseCase(sl()));
  sl.registerLazySingleton(() => GetUserSettingsByPkUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserDetailByPkUseCase(sl()));
  sl.registerLazySingleton(() => GetUserDetailByPkUseCase(sl()));
  sl.registerLazySingleton(() => ClearUserHistoryUseCase(sl()));
  sl.registerLazySingleton(() => ClearAllUsersUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserHistoryUseCase(sl()));
  sl.registerLazySingleton(() => InsertUserDetailByPkUseCase(sl()));
  sl.registerLazySingleton(() => ClearAllUserDetailUseCase(sl()));
  sl.registerLazySingleton(() => ClearAllUserSettingsUseCase(sl()));
  sl.registerLazySingleton(() => GetTFLiteCalloryUseCase(sl()));

  // --- Bloc --- \\
  sl.registerLazySingleton(() => AuthAdminBloc(setCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => AuthBloc(setCacheStartAppUserCase: sl(), getCacheStartAppUserCase: sl()));
  sl.registerLazySingleton(() => SplashBloc(
        getCacheStartAppUserCase: sl(),
        globalSettingsService: sl(),
      ));
  sl.registerLazySingleton(() => HomeBloc(getConnectedDeviceUseCase: sl(), appBluetoothService: sl()));
  sl.registerLazySingleton(() => ConnectedDeviceBloc(appBluetoothService: sl()));
  sl.registerLazySingleton(() => ConnectDeviceBloc(appBluetoothService: sl()));
  sl.registerLazySingleton(() => PreviouslyConnectedBloc(appBluetoothService: sl(), getUsersUserCase: sl()));
  sl.registerLazySingleton(() => ScanDeviceBloc(appBluetoothService: sl()));
  sl.registerLazySingleton(() => AutoConnectBloc(appBluetoothService: sl(), getUsersUseCase: sl()));
  sl.registerLazySingleton(() => HistoryBloc(getUsersUseCase: sl(), removeUserByPkUseCase: sl()));
  sl.registerLazySingleton(() => GlobalSettingsBloc(globalSettingsService: sl()));
  sl.registerLazySingleton(() => UserEditBloc(
        getUserByPkUseCase: sl(),
        getUserDetailByPkUseCase: sl(),
        updateUserByPkUseCase: sl(),
        insertUserDetailByPkUseCase: sl(),
        getUserSettingsByPkUseCase: sl(),
        insertUserSettingsByPkUseCase: sl(),
      ));

  sl.registerLazySingleton(() => HistoryDetailBloc(
        getUserByPkUseCase: sl(),
        getUserHistoryUserByPkUseCase: sl(),
        deleteUserHistoryByPkUseCase: sl(),
        updateUserUseCase: sl(),
        getUserDetailByPkUseCase: sl(),
        getTFLiteCalloryUseCase: sl(),
        insertUserHistoryUseCase: sl(),
      ));

  sl.registerLazySingleton(() => SettingsBloc(
        clearCacheStartAppUseCase: sl(),
        setCacheStartAppUseCase: sl(),
        getCacheStartAppUseCase: sl(),
        clearAllUserHistoryUseCase: sl(),
        clearAllUsersUseCase: sl(),
        clearAllUserDetailByPkUseCase: sl(),
        clearAllUserSettingsUseCase: sl(),
      ));

  // --- Other --- \\

  final appBluetoothService = await AppBluetoothService().init();
  final sqlLiteService = await SqlLiteService().init();
  final hiveService = await HiveService().init();
  final tfliteService = await TFLiteService().init();

  final appNotificationService = AppNotificationService()..init();

  sl.registerLazySingleton(() => tfliteService);
  sl.registerLazySingleton(() => globalSettingsService);
  sl.registerLazySingleton(() => appNotificationService);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => sqlLiteService);
  sl.registerLazySingleton(() => hiveService);
  sl.registerLazySingleton(() => appBluetoothService);
  sl.registerLazySingleton(() => SettingsUtils(sl()));
  sl.registerLazySingleton(() => AppRouter());
}

Future<void> registerHiveOrSqlModules(GlobalSettingsService globalSettingsService) async {
  final isMigrateHive = globalSettingsService.appSettings.isMigratedHive;

  if (sl.isRegistered<UserDataSource>()) {
    await sl.unregister<UserDataSource>();
  }
  if (sl.isRegistered<UserHistoryDataSource>()) {
    await sl.unregister<UserHistoryDataSource>();
  }

  sl.registerLazySingleton<UserDataSource>(
    () => isMigrateHive
        ? UserDataSourceHiveImpl(
            hiveService: sl(),
          )
        : UserDataSourceSqlImpl(
            sqlLiteService: sl(),
          ),
  );
  sl.registerLazySingleton<UserHistoryDataSource>(
    () => isMigrateHive
        ? UserHistoryDataSourceHiveImpl(
            hiveService: sl(),
          )
        : UserHistoryDataSourceSqlImpl(
            sqlLiteService: sl(),
          ),
  );
}
