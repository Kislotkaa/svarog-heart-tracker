import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';
import 'package:svarog_heart_tracker/core/service/database/datasourse/start_app_datasource.dart';

abstract class StartAppRepository {
  Future<Either<Failure, StartAppModel?>> getStartAppModel();
  Future<Either<Failure, void>> setStartAppModel(StartAppModel params);
  Future<Either<Failure, void>> clearStartAppModel();
}

class StartAppRepositoryImpl extends StartAppRepository {
  final StartAppDataSource startAppDataSource;

  StartAppRepositoryImpl({
    required this.startAppDataSource,
  });

  @override
  Future<Either<CacheFailure, StartAppModel?>> getStartAppModel() async {
    try {
      final model = startAppDataSource.getData();

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<CacheFailure, void>> setStartAppModel(StartAppModel params) async {
    try {
      startAppDataSource.setData(params);

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }

  @override
  Future<Either<Failure, void>> clearStartAppModel() async {
    try {
      await startAppDataSource.clearData();

      return const Right(null);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
