import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_history_repository.dart';

class GetHistoryByPkUseCase extends UseCase<UserHistoryModel?, String> {
  final UserHistoryRepository userHistoryRepository;

  GetHistoryByPkUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, UserHistoryModel?>> call(String params) async {
    final response = await userHistoryRepository.getHistoryByPk(params);
    return response;
  }
}
