import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/repository/user_history_repository.dart';

class InsertUserHistoryUseCase extends UseCase<void, UserHistoryModel> {
  final UserHistoryRepository userHistoryRepository;

  InsertUserHistoryUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, void>> call(UserHistoryModel params) async {
    final model = await userHistoryRepository.insertUserHistory(params);
    return model;
  }
}
