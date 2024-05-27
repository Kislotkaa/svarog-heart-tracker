import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_detail_repository.dart';

import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class RemoveUserDetailByPkUseCase extends UseCase<void, String> {
  final UserDetailRepository userDetailRepository;

  RemoveUserDetailByPkUseCase(this.userDetailRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final response = await userDetailRepository.removeDetailByPk(params);
    return response;
  }
}
