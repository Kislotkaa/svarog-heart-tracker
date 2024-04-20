import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/feature/home/domain/datasource/user_datasource.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, UserModel?>> getUserByPk(String id);
  Future<Either<Failure, UserModel?>> updateUserByPk(UserParams params);
  Future<Either<Failure, void>> insertUser(UserParams params);
  Future<Either<Failure, void>> removeUserByPk(String id);
}

class UserRepositoryImpl extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<Either<CacheFailure, List<UserModel>>> getUsers() async {
    try {
      final model = await userDataSource.getUsers();

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getUserByPk(String id) async {
    try {
      final model = await userDataSource.getUserByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserParams params) async {
    try {
      await userDataSource.insertUser(params);

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> removeUserByPk(String id) async {
    try {
      final model = await userDataSource.removeUserByPk(id);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, UserModel?>> updateUserByPk(UserParams params) async {
    try {
      final model = await userDataSource.updateUserByPk(params);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
