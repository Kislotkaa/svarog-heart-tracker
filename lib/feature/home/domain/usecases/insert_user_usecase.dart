import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_repository.dart';

class InsertUserUseCase extends UseCase<void, UserParams> {
  final UserRepository userHistoryRepository;

  InsertUserUseCase(this.userHistoryRepository);

  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    final model = await userHistoryRepository.insertUser(params);
    return model;
  }
}
