import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/utils/service/database/repository/user_history_repository.dart';

class GetUserHistoryUserByPkUseCase extends UseCase<List<UserHistoryModel>, String> {
  final UserHistoryRepository userHistoryRepository;

  GetUserHistoryUserByPkUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, List<UserHistoryModel>>> call(String params) async {
    final response = await userHistoryRepository.getUserHistoryUserByPk(params);
    return response;
  }
}
