import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_detail_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class InsertUserDetailByPkUseCase extends UseCase<UserDetailModel, UserDetailModel> {
  final UserDetailRepository userDetailRepository;

  InsertUserDetailByPkUseCase(this.userDetailRepository);

  @override
  Future<Either<Failure, UserDetailModel>> call(UserDetailModel params) async {
    final response = await userDetailRepository.insertUserDetailByPk(params);
    return response;
  }
}

class UserDetailParams {
  UserDetailParams({
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
  });

  final int gender;
  final int? age;
  final double? height;
  final double? weight;
}
