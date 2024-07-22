import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/constant/constants.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class InsertUserSettingsByPkUseCase extends UseCase<UserSettingsModel?, UserSettingsModel> {
  final UserSettingsRepository userSettingsRepository;

  InsertUserSettingsByPkUseCase(this.userSettingsRepository);

  @override
  Future<Either<Failure, UserSettingsModel?>> call(UserSettingsModel params) async {
    final response = await userSettingsRepository.insertUserSettingsByPk(params);
    return response;
  }
}

class UserSettingsParams {
  UserSettingsParams({
    this.greenZone = HeartZone.greenZone, // Порог зелёной зоны
    this.orangeZone = HeartZone.orangeZone, // Порог красной зоны
  });

  final int greenZone;
  final int orangeZone;
}
