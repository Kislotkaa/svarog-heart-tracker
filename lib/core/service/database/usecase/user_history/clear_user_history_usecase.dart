import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_history_repository.dart';

class ClearUserHistoryUseCase extends UseCase<void, NoParams> {
  final UserHistoryRepository userHistoryRepository;

  ClearUserHistoryUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final model = await userHistoryRepository.clearDatabase();
    return model;
  }
}
