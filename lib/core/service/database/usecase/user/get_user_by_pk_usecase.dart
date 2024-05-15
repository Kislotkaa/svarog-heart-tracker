import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_repository.dart';

class GetUserByPkUseCase extends UseCase<UserModel?, String> {
  final UserRepository userRepository;

  GetUserByPkUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserModel?>> call(String params) async {
    final response = await userRepository.getUserByPk(params);
    return response;
  }
}
