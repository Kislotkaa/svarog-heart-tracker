import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/feature/home/domain/datasource/user_history_datasource.dart';

abstract class UserHistoryRepository {
  Future<Either<Failure, List<UserHistoryModel>>> getUserHistoryUserByPk(String id);
  Future<Either<Failure, UserHistoryModel?>> getHistoryByPk(String id);
  Future<Either<Failure, void>> insertHistory(UserHistoryModel params);
  Future<Either<Failure, void>> removeHistoryByPk(String id);
  Future<Either<Failure, void>> clearDatabase();
}

class UserHistoryRepositoryImpl extends UserHistoryRepository {
  final UserHistoryDataSource userHistoryDataSource;

  UserHistoryRepositoryImpl({
    required this.userHistoryDataSource,
  });

  @override
  Future<Either<Failure, UserHistoryModel?>> getHistoryByPk(String id) async {
    try {
      final model = await userHistoryDataSource.getHistoryByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, List<UserHistoryModel>>> getUserHistoryUserByPk(String id) async {
    try {
      final model = await userHistoryDataSource.getUserHistoryByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> insertHistory(UserHistoryModel params) async {
    try {
      await userHistoryDataSource.insertHistory(params);

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> removeHistoryByPk(String id) async {
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
}
