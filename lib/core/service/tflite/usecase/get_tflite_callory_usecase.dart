import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/tflite/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class GetTFLiteCalloryUseCase extends UseCase<UserHistoryModel?, TFLiteParams> {
  final TFLiteRepository tfLiteRepository;

  GetTFLiteCalloryUseCase(this.tfLiteRepository);

  @override
  Future<Either<Failure, UserHistoryModel?>> call(TFLiteParams params) async {
    final response = await tfLiteRepository.getTFLiteCallory(params);
    return response;
  }
}

class TFLiteParams {
  final UserDetailModel detail;
  final UserHistoryModel history;

  TFLiteParams({
    required this.detail,
    required this.history,
  });
}
