import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_detail_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class ClearAllUserDetailUseCase extends UseCase<void, NoParams> {
  final UserDetailRepository userDetailRepository;

  ClearAllUserDetailUseCase(this.userDetailRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final response = await userDetailRepository.clearDatabase();
    return response;
  }
}
