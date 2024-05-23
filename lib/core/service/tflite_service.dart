import 'dart:developer';

import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  static const String PATH_MODEL = 'assets/model.tflite';
  late Interpreter? interpreter;

  TFLiteService();

  Future<TFLiteService> init() async {
    // TODO: Пока что в коммент так как нету модели которую инициализируем
    try {
      interpreter = await tfl.Interpreter.fromAsset(PATH_MODEL);
      log('Tflite Initial path: $PATH_MODEL');
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return this;
  }

  Future<UserHistoryModel?> isolateCalculateCallory(UserDetailModel detail, UserHistoryModel history) async {
    if (interpreter == null) return null;

    if (history.finishedAt == null && history.createAt == null) {
      return null;
    }

    final int duration = history.finishedAt!.difference(history.createAt!).inMinutes;

    final params = TFLiteParams(
      age: detail.age,
      gender: detail.gender,
      height: detail.height,
      weight: detail.weight,
      duration: duration.toDouble(),
      avgHeartRate: history.avgHeart.toDouble(),
    );

    final calories = await runModel(params);

    final model = history.copyWith(calories: calories);
    return model;
  }

  Future<double?> runModel(TFLiteParams params) async {
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

class TFLiteParams {
  final int gender;
  final int age;
  final double height;
  final double weight;
  final double duration; // в минутах
  final double avgHeartRate;

  TFLiteParams({
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.duration,
    required this.avgHeartRate,
  });
}
