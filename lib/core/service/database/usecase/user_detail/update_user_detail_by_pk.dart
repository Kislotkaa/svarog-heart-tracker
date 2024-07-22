import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_detail_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class UpdateUserDetailByPkUseCase extends UseCase<UserDetailModel, UserDetailModel> {
  final UserDetailRepository userDetailRepository;

  UpdateUserDetailByPkUseCase(this.userDetailRepository);

  @override
  Future<Either<Failure, UserDetailModel>> call(UserDetailModel params) async {
    final response = await userDetailRepository.updateUserDetailByPk(params);
    return response;
  }
}
