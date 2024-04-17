import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/repository/start_app_repository.dart';

class SetCacheStartAppUseCase extends UseCase<void, StartAppModel> {
  final StartAppRepository startAppRepository;

  SetCacheStartAppUseCase(this.startAppRepository);

  @override
  Future<Either<Failure, void>> call(StartAppModel params) async {
    final response = await startAppRepository.setStartAppModel(params);
    return response;
  }
}
