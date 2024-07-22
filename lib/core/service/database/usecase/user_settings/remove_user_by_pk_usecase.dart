import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class RemoveUserSettingsByPkUseCase extends UseCase<void, String> {
  final UserSettingsRepository userSettingsRepository;

  RemoveUserSettingsByPkUseCase(this.userSettingsRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    final response = await userSettingsRepository.removeSettingsByPk(params);
    return response;
  }
}
