import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/user_settings_repository.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

class ClearAllUserSettingsUseCase extends UseCase<void, NoParams> {
  final UserSettingsRepository userSettingsRepository;

  ClearAllUserSettingsUseCase(this.userSettingsRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final response = await userSettingsRepository.clearDatabase();
    return response;
  }
}
