import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class UpdateUserSettingsByPkUseCase extends UseCase<UserSettingsModel?, UserSettingsModel> {
  final UserSettingsRepository userRepository;

  UpdateUserSettingsByPkUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserSettingsModel?>> call(UserSettingsModel params) async {
    final response = await userRepository.updateUserSettingsByPk(params);
    return response;
  }
}
