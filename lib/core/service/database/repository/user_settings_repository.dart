import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_settings_datasource.dart';
import 'package:svarog_heart_tracker/feature/user_serttings/data/user_settings_params.dart';

abstract class UserHistoryRepository {
  Future<Either<Failure, UserSettingsModel>> getUserSettingsByPk(String id);
  Future<Either<Failure, UserSettingsModel>> updateUserSettingsByPk(UserSettingsParams params);
  Future<Either<Failure, void>> clearDatabase();
}

class UserHistoryRepositoryImpl extends UserHistoryRepository {
  final UserSettingsDataSource userSettingsDataSource;

  UserHistoryRepositoryImpl({
    required this.userSettingsDataSource,
  });

  @override
  Future<Either<Failure, UserSettingsModel>> getUserSettingsByPk(String id) async {
    try {
      final model = await userSettingsDataSource.getUserSettingsByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, UserSettingsModel>> updateUserSettingsByPk(UserSettingsParams params) async {
    try {
      final model = await userSettingsDataSource.updateUserSettingsByPk(params);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> clearDatabase() async {
    try {
      await userSettingsDataSource.clearDatabase();

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
