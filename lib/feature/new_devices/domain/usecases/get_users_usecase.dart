import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/home/domain/repository/user_repository.dart';

class GetUsersUseCase extends UseCase<List<UserModel>, NoParams> {
  final UserRepository userRepository;

  GetUsersUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) async {
    final response = await userRepository.getUsers();
    return response;
  }
}
