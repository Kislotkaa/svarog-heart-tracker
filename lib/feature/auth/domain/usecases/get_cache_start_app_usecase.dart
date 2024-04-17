import 'package:dartz/dartz.dart';
import 'package:svarog_heart_tracker/core/error_handler/failure_cache.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';
import 'package:svarog_heart_tracker/feature/auth/domain/repository/start_app_repository.dart';

class GetCacheStartAppUseCase extends UseCase<StartAppModel?, NoParams> {
  final StartAppRepository startAppRepository;

  GetCacheStartAppUseCase(this.startAppRepository);

  @override
  Future<Either<Failure, StartAppModel?>> call(NoParams params) async {
    final response = await startAppRepository.getStartAppModel();
    return response;
  }
}
