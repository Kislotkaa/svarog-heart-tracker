import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_history_repository.dart';

class RemoveUserHistoryUserByPkUseCase extends UseCase<void, String> {
  final UserHistoryRepository userHistoryRepository;

  RemoveUserHistoryUserByPkUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final response = await userHistoryRepository.removeUserHistoryUserByPk(params);
    return response;
  }
}
