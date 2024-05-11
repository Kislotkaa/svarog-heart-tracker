import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/repository/user_history_repository.dart';

class GetUserHistoryByPkUseCase extends UseCase<UserHistoryModel?, String> {
  final UserHistoryRepository userHistoryRepository;

  GetUserHistoryByPkUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, UserHistoryModel?>> call(String params) async {
    final response = await userHistoryRepository.getUserHistoryByPk(params);
    return response;
  }
}
