import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/repository/start_app_repository.dart';

class ClearCacheStartAppUseCase extends UseCase<void, NoParams> {
  final StartAppRepository startAppRepository;

  ClearCacheStartAppUseCase(this.startAppRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final response = await startAppRepository.clearStartAppModel();
    return response;
  }
}
