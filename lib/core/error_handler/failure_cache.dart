import 'package:svarog_heart_tracker/core/error_handler/http_error_model.dart';

abstract class Failure {
  CacheErrorModel? get data => CacheErrorModel();
}

class CacheFailure extends Failure {
  const factory CacheFailure.somethingFailure() = SomethingCacheFailure;
}

class SomethingCacheFailure implements CacheFailure {
  const SomethingCacheFailure();

  @override
  CacheErrorModel? get data => null;
}
