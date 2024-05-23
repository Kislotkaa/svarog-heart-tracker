import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/user_detail_datasource.dart';

abstract class UserDetailRepository {
  Future<Either<Failure, UserDetailModel?>> getUserDetailByPk(String id);
  Future<Either<Failure, UserDetailModel>> updateUserDetailByPk(UserDetailModel params);
  Future<Either<Failure, UserDetailModel>> insertUserDetailByPk(UserDetailModel params);
  Future<Either<Failure, void>> clearDatabase();
}

class UserDetailRepositoryImpl extends UserDetailRepository {
  final UserDetailDataSource userDetailDataSource;

  UserDetailRepositoryImpl({
    required this.userDetailDataSource,
  });

  @override
  Future<Either<Failure, UserDetailModel?>> getUserDetailByPk(String id) async {
    try {
      final model = await userDetailDataSource.getUserDetailByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, UserDetailModel>> updateUserDetailByPk(UserDetailModel params) async {
    try {
      final model = await userDetailDataSource.updateUserDetailByPk(params);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, UserDetailModel>> insertUserDetailByPk(UserDetailModel params) async {
    try {
      final model = await userDetailDataSource.insertUserDetailByPk(params);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> clearDatabase() async {
    try {
      await userDetailDataSource.clearDatabase();

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
