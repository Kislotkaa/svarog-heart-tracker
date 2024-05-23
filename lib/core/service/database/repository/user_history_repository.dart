import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_history_datasource.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_user_by_pk_usecase.dart';

abstract class UserHistoryRepository {
  Future<Either<Failure, List<UserHistoryModel>>> getUserHistoryUserByPk(GetUserHistoryParams params);
  Future<Either<Failure, UserHistoryModel?>> getUserHistoryByPk(String id);
  Future<Either<Failure, void>> insertUserHistory(UserHistoryModel params);
  Future<Either<Failure, void>> updateHistoryByPk(UserHistoryModel params);
  Future<Either<Failure, void>> removeUserHistoryByPk(String id);
  Future<Either<Failure, void>> clearDatabase();
}

class UserHistoryRepositoryImpl extends UserHistoryRepository {
  final UserHistoryDataSource userHistoryDataSource;

  UserHistoryRepositoryImpl({
    required this.userHistoryDataSource,
  });

  @override
  Future<Either<Failure, UserHistoryModel?>> getUserHistoryByPk(String id) async {
    try {
      final model = await userHistoryDataSource.getHistoryByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, List<UserHistoryModel>>> getUserHistoryUserByPk(GetUserHistoryParams params) async {
    try {
      final model = await userHistoryDataSource.getUserHistoryByPk(params);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> insertUserHistory(UserHistoryModel params) async {
    try {
      await userHistoryDataSource.insertHistory(params);

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> removeUserHistoryByPk(String id) async {
    try {
      await userHistoryDataSource.removeHistoryByPk(id);

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> clearDatabase() async {
    try {
      await userHistoryDataSource.clearDatabase();

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> updateHistoryByPk(UserHistoryModel params) async {
    try {
      await userHistoryDataSource.updateHistoryByPk(params);

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
