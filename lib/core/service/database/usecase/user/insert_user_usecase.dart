import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';

class InsertUserUseCase extends UseCase<void, UserParams> {
  final UserRepository userRepository;

  InsertUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    final model = await userRepository.insertUser(params);
    return model;
  }
}
