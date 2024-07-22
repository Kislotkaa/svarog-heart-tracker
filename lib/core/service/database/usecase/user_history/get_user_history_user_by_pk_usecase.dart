import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_history_repository.dart';

class GetUserHistoryUserByPkUseCase extends UseCase<List<UserHistoryModel>, GetUserHistoryParams> {
  final UserHistoryRepository userHistoryRepository;

  GetUserHistoryUserByPkUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, List<UserHistoryModel>>> call(GetUserHistoryParams params) async {
    final response = await userHistoryRepository.getUserHistoryUserByPk(params);
    return response;
  }
}

class GetUserHistoryParams {
  final String userId;
  final HivePagination? pagination;

  GetUserHistoryParams({required this.userId, this.pagination});
}
