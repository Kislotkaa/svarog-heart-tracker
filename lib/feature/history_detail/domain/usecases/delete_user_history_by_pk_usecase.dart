import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_history_repository.dart';

class DeleteUserHistoryByPkUseCase extends UseCase<void, String> {
  final UserHistoryRepository userHistoryRepository;

  DeleteUserHistoryByPkUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final response = await userHistoryRepository.removeHistoryByPk(params);
    return response;
  }
}
