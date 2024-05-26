import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/tflite/tflite_service.dart';
import 'package:svarog_heart_tracker/core/service/tflite/usecase/get_tflite_callory_usecase.dart';

abstract class TFLiteDataSource {
  Future<UserHistoryModel?> getTFLiteCallory(TFLiteParams params);
}

class TFLiteDataSourceImpl extends TFLiteDataSource {
  final TFLiteService tfLiteService;

  TFLiteDataSourceImpl({required this.tfLiteService});

  @override
  Future<UserHistoryModel?> getTFLiteCallory(TFLiteParams params) async {
    final result = await tfLiteService.isolateCalculateCallory(params);

    return result;
  }
}
