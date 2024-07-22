import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';

class RemoveUserByPkUseCase extends UseCase<void, String> {
  final UserRepository userRepository;

  RemoveUserByPkUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final response = await userRepository.removeUserByPk(params);
    return response;
  }
}
