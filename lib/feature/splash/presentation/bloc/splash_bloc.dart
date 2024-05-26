import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/app.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/l10n/generated/l10n.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_history_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_settings_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_history_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/clear_all_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_users_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/clear_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/insert_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/start_app/usecase/get_cache_start_app_usecase.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/compress_data.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/locator.dart';
import 'package:uuid/uuid.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  /// ----- SQL IMPORITS -----
  /// **[NoParams]** required
  final GetUsersUseCase getUsersSqlUseCase = GetUsersUseCase(
    UserRepositoryImpl(
      userDataSource: UserDataSourceSqlImpl(
        sqlLiteService: sl(),
      ),
    ),
  );

  /// **[NoParams]** required
  final GetUserHistoryUserByPkUseCase getUserHistoryUserByPkSqlUseCase = GetUserHistoryUserByPkUseCase(
    UserHistoryRepositoryImpl(
      userHistoryDataSource: UserHistoryDataSourceSqlImpl(
        sqlLiteService: sl(),
      ),
    ),
  );

  final ClearAllUsersUseCase clearUserSqlUseCase = ClearAllUsersUseCase(
    UserRepositoryImpl(
      userDataSource: UserDataSourceSqlImpl(
        sqlLiteService: sl(),
      ),
    ),
  );

  final ClearUserHistoryUseCase clearUserHistorySqlUseCase = ClearUserHistoryUseCase(
    UserHistoryRepositoryImpl(
      userHistoryDataSource: UserHistoryDataSourceSqlImpl(
        sqlLiteService: sl(),
      ),
    ),
  );

  /// ----- HIVE IMPORITS -----
  /// **[UserParams]** required
  final InsertUserUseCase insertUserHiveUseCase = InsertUserUseCase(
    UserRepositoryImpl(
      userDataSource: UserDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  /// **[UserHistoryModel]** required
  final InsertUserHistoryUseCase insertUserHistoryHiveUseCase = InsertUserHistoryUseCase(
    UserHistoryRepositoryImpl(
      userHistoryDataSource: UserHistoryDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  /// **[UserSettingsModel]** required
  final InsertUserSettingsByPkUseCase insertUserSettingsByPkUseCase = InsertUserSettingsByPkUseCase(
    UserSettingsRepositoryImpl(
      userSettingsDataSource: UserSettingsDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  final ClearAllUsersUseCase clearUserHiveUseCase = ClearAllUsersUseCase(
    UserRepositoryImpl(
      userDataSource: UserDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  final ClearUserHistoryUseCase clearUserHistoryHiveUseCase = ClearUserHistoryUseCase(
    UserHistoryRepositoryImpl(
      userHistoryDataSource: UserHistoryDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  final GetUsersUseCase getUsersHiveUseCase = GetUsersUseCase(
    UserRepositoryImpl(
      userDataSource: UserDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  final GetUserHistoryUserByPkUseCase getUserHistoryUserByPkHiveUseCase = GetUserHistoryUserByPkUseCase(
    UserHistoryRepositoryImpl(
      userHistoryDataSource: UserHistoryDataSourceHiveImpl(
        hiveService: sl(),
      ),
    ),
  );

  /// ----- ------------- -----

  /// **[NoParams]** required
  final GetCacheStartAppUseCase getCacheStartAppUserCase;

  final GlobalSettingsService globalSettingsService;

  SplashBloc({
    required this.getCacheStartAppUserCase,
    required this.globalSettingsService,
  }) : super(const SplashState.initial()) {
    on<SplashInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorTitle: null,
          errorMessage: null,
        ),
      );

      /// TODO: Тестовые данные для проверки работы миграции!!!
      // if (kDebugMode) {
      //   await globalSettingsService.setMigratedHive(false);

      //   await registerHiveOrSqlModules(globalSettingsService);

      //   await clearUserSqlUseCase(NoParams());
      //   await clearUserHistorySqlUseCase(NoParams());
      //   await clearUserHiveUseCase(NoParams());
      //   await clearUserHistoryHiveUseCase(NoParams());

      //   final userSqlDataSource = UserDataSourceSqlImpl(sqlLiteService: sl());
      //   final userHistorySqlDataSource = UserHistoryDataSourceSqlImpl(sqlLiteService: sl());

      //   for (var i = 0; i < 3; i++) {
      //     await userSqlDataSource.insertUser(
      //       UserParams(
      //         id: i.toString(),
      //         personName: 'personName$i',
      //         deviceName: 'deviceName$i',
      //       ),
      //     );
      //   }

      //   final users = await userSqlDataSource.getUsers();

      //   for (var i = 0; i < users.length; i++) {
      //     for (var j = 0; j < 3; j++) {
      //       await userHistorySqlDataSource.insertHistory(UserHistoryModel(
      //         id: '${users[i].id}.$j',
      //         userId: users[i].id,
      //         yHeart: [1, 2, 3, 4, 5, 6],
      //         maxHeart: 6,
      //         minHeart: 1,
      //         avgHeart: 3,
      //         redTimeHeart: 7,
      //         orangeTimeHeart: 8,
      //         greenTimeHeart: 9,
      //         createAt: DateTime.now(),
      //         finishedAt: DateTime.now(),
      //       ));
      //     }
      //   }

      //   for (var i = 0; i < users.length; i++) {
      //     log('id:${users[i].id}');
      //     log('userDetailId:${users[i].userDetailId}');
      //     log('userSettingsId:${users[i].userSettingsId}');
      //     log('personName:${users[i].personName}');
      //     log('deviceName:${users[i].deviceName}');
      //     log('isAutoConnect:${users[i].isAutoConnect}');

      //     final history = await userHistorySqlDataSource.getUserHistoryByPk(users[i].id);
      //     for (var elementHistory in history) {
      //       log('------ id:${elementHistory.id}');
      //       log('------ userId:${elementHistory.userId}');
      //       log('------ yHeart:${elementHistory.yHeart.getRange(0, 5)}');
      //       log('------ maxHeart:${elementHistory.maxHeart}');
      //       log('------ minHeart:${elementHistory.minHeart}');
      //       log('------ avgHeart:${elementHistory.avgHeart}');
      //       log('------ redTimeHeart:${elementHistory.redTimeHeart}');
      //       log('------ orangeTimeHeart:${elementHistory.orangeTimeHeart}');
      //       log('------ greenTimeHeart:${elementHistory.greenTimeHeart}');
      //       log('------ createAt:${elementHistory.createAt}');
      //       log('------ finishedAt:${elementHistory.finishedAt}');
      //       log('------ calories:${elementHistory.calories}');
      //     }
      //     print('@@@');
      //   }
      //   log('--------------------------------------');
      // }

      /// Миграция на Hive под загрузку splash screen
      /// ------------------------------------------------------------------------------------------
      /// ВАЖНО НЕ УБИРАТЬ
      final isMigrateHive = globalSettingsService.appSettings.isMigratedHive;
      final hiveIsEmpty = await sl<HiveService>().dataBaseIsEmpty();

      late List<UserModel> users = [];

      if (isMigrateHive == false && hiveIsEmpty) {
        emit(
          state.copyWith(
            process: 'Идёт оптимизация данных...',
            errorTitle: null,
            errorMessage: null,
          ),
        );

        /// Получаем всех пользователей из SQLite бд
        final failureOrUsers = await getUsersSqlUseCase(NoParams());
        failureOrUsers.fold((l) async {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              process: 'Произошла ошибка во время миграции Истории подключений',
              errorTitle: S.of(externalContext).error,
              errorMessage: 'Произошла ошибка во время миграции',
            ),
          );
          return;
        }, (usersReturned) => users = usersReturned);

        /// Перебираем полученных пользователей
        for (var elementUser in users) {
          late UserModel user = elementUser;

          /// Добавляем настройки в Hive бд если их нет
          if (user.userSettingsId == null) {
            final settingsId = const Uuid().v4();
            final failureOrSettings = await insertUserSettingsByPkUseCase(UserSettingsModel(id: settingsId));
            failureOrSettings.fold((l) {
              emit(
                state.copyWith(
                  status: StateStatus.failure,
                  process: 'Произошла ошибка во время миграции Настроек',
                  errorTitle: S.of(externalContext).error,
                  errorMessage: 'Произошла ошибка во время миграции',
                ),
              );
              return;
            }, (settings) => user = user.copyWith(userSettingsId: settingsId));
          }

          /// Добавляем пользователя в Hive бд
          final failureOrInsertUser = await insertUserHiveUseCase(UserParams(
            id: user.id,
            userSettingsId: user.id,
            userDetailId: user.userDetailId,
            personName: user.personName,
            deviceName: user.deviceName,
            isAutoConnect: user.isAutoConnect,
          ));
          failureOrInsertUser.fold((l) {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                process: 'Произошла ошибка во время миграции Истории подключений',
                errorTitle: S.of(externalContext).error,
                errorMessage: 'Произошла ошибка во время миграции',
              ),
            );
            return;
          }, (inserted) {});

          // Получаем историю этого пользователя из SQLite бд
          final failureOrHistory = await getUserHistoryUserByPkSqlUseCase(GetUserHistoryParams(userId: user.id));
          List<UserHistoryModel> historis = [];
          failureOrHistory.fold((l) async {
            emit(
              state.copyWith(
                status: StateStatus.failure,
                process: 'Произошла ошибка во время миграции Истории тренировок',
                errorTitle: S.of(externalContext).error,
                errorMessage: 'Произошла ошибка во время миграции',
              ),
            );
            return;
          }, (historisReturned) => historis = historisReturned);

          // Перебираем полученную историю пользователя и добавляем её в Hive бд
          for (var elementHistory in historis) {
            // Сжимаем список что бы не было перегрузки на экране историй
            List<int> yHeart = compressArray(elementHistory.yHeart);
            UserHistoryModel history = elementHistory.copyWith(yHeart: yHeart);

            final failureOrInsertHistory = await insertUserHistoryHiveUseCase(history);
            failureOrInsertHistory.fold((l) {
              emit(
                state.copyWith(
                  status: StateStatus.failure,
                  process: 'Произошла ошибка во время миграции Истории тренировок',
                  errorTitle: S.of(externalContext).error,
                  errorMessage: 'Произошла ошибка во время миграции',
                ),
              );
              return;
            }, (inserted) {});
          }
        }

        await clearUserSqlUseCase(NoParams());
        await clearUserHistorySqlUseCase(NoParams());
        await globalSettingsService.setMigratedHive(true);
        await registerHiveOrSqlModules(globalSettingsService);

        await Future.delayed(const Duration(seconds: 1));

        emit(
          state.copyWith(
            process: 'Готово',
            errorTitle: null,
            errorMessage: null,
          ),
        );
      }

      /// ------------------------------------------------------------------------------------------

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
