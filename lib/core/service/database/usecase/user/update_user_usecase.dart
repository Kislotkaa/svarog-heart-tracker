import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';

class UpdateUserUseCase extends UseCase<UserModel?, UserParams> {
  final UserRepository userRepository;

  UpdateUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserModel?>> call(UserParams params) async {
    final response = await userRepository.updateUserByPk(params);
    return response;
  }
}
