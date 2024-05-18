import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class ClearUserUseCase extends UseCase<void, NoParams> {
  final UserRepository userRepository;

  ClearUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final model = await userRepository.clearDatabase();
    return model;
  }
}
