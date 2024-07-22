import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/tflite/detasource/user_settings_datasource.dart';
import 'package:svarog_heart_tracker/core/service/tflite/usecase/get_tflite_callory_usecase.dart';

abstract class TFLiteRepository {
  Future<Either<Failure, UserHistoryModel?>> getTFLiteCallory(TFLiteParams params);
}

class TFLiteRepositoryImpl extends TFLiteRepository {
  final TFLiteDataSource tfLiteDataSource;

  TFLiteRepositoryImpl({
    required this.tfLiteDataSource,
  });

  @override
  Future<Either<Failure, UserHistoryModel?>> getTFLiteCallory(TFLiteParams params) async {
    try {
      final model = await tfLiteDataSource.getTFLiteCallory(params);

      return Right(model);
    } on CacheFailure catch (exception) {
      return Left(exception);
    }
  }
}
