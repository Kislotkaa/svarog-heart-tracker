import 'dart:developer';

import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/update_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  final UpdateUserHistoryUseCase updateUserHistoryUseCase;
  static const String PATH_MODEL = 'assets/your_model.tflite';
  late Interpreter? interpreter;

  TFLiteService(this.updateUserHistoryUseCase);

  Future<TFLiteService> init() async {
    // TODO: Пока что в коммент так как нету модели которую инициализируем
    // try {
    //   interpreter = await tfl.Interpreter.fromAsset(PATH_MODEL);
    // } catch (e, s) {
    //   ErrorHandler.getMessage(e, s);
    // }
    return this;
  }

  Future<void> isolateCalculateCallory(UserHistoryModel params) async {
    if (interpreter == null) return;

    final calories = await runModel();

    final model = params.copyWith(calories: calories);
    final failurOrUpdate = await updateUserHistoryUseCase(model);

    failurOrUpdate.fold((l) => log('Calories calculate FAILUR'), (success) => log('Calories calculate success'));
  }

  Future<double?> runModel() async {
    try {
      final input = [
        [1.23, 6.54, 7.81, 3.21, 2.22]
      ];

      // if output tensor shape [1,2] and type is float32
      final List output = List.filled(1 * 2, 0).reshape([1, 2]);
      final isolateInterpreter = await IsolateInterpreter.create(address: interpreter!.address);
      await isolateInterpreter.run(input, output);

      if (output is List<double>) return output.firstOrNull;
      return null;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
      return null;
    }
  }

  double minMaxScaler(double min, double max) {
    return 0.0;
  }
}
