import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_history_repository.dart';

class ClearDatabaseUseCase extends UseCase<void, NoParams> {
  final UserHistoryRepository userHistoryRepository;

  ClearDatabaseUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final response = await userHistoryRepository.clearDatabase();
    return response;
  }
}
