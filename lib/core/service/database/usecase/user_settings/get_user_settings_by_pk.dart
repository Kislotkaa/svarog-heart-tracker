import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class GetUserSettingsByPkUseCase extends UseCase<UserSettingsModel?, String> {
  final UserSettingsRepository userSettingsRepository;

  GetUserSettingsByPkUseCase(this.userSettingsRepository);

  @override
  Future<Either<Failure, UserSettingsModel?>> call(String params) async {
    final response = await userSettingsRepository.getUserSettingsByPk(params);
    return response;
  }
}
