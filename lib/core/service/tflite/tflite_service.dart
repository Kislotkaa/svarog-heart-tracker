import 'dart:developer';

import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/tflite/usecase/get_tflite_callory_usecase.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  static const String PATH_MODEL = 'assets/model.tflite';
  IsolateInterpreter? isolateInterpreter;
  TFLiteService();

  Future<TFLiteService> init() async {
    // TODO: Пока что в коммент так как нету модели которую инициализируем
    try {
      final interpreter = await tfl.Interpreter.fromAsset(PATH_MODEL);
      isolateInterpreter = await IsolateInterpreter.create(address: interpreter.address);
      log('Tflite Initial path: $PATH_MODEL');
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return this;
  }

  Future<UserHistoryModel?> isolateCalculateCallory(TFLiteParams params) async {
    final finishedAt = params.history.finishedAt;
    final createAt = params.history.createAt;

    final detail = params.detail;
    final history = params.history;

    if (isolateInterpreter == null || finishedAt == null && createAt == null) {
      return null;
    }

    final int duration = finishedAt!.difference(createAt!).inMinutes;

    final runModel = TFLiteRunModel(
      age: detail.age,
      gender: detail.gender,
      height: detail.height,
      weight: detail.weight,
      duration: duration.toDouble(),
      avgHeartRate: history.avgHeart.toDouble(),
    );

    final calories = await run(runModel);

    final model = history.copyWith(calories: calories);
    return model;
  }

  Future<double?> run(TFLiteRunModel model) async {
    try {
      final input = [
        model.gender.toDouble(),
        model.age.toDouble(),
        model.height,
        model.weight,
        model.duration,
        model.avgHeartRate
      ];

      /// output всегда 1 на 1 размерности
      final List output = List.filled(1 * 1, 0).reshape([1, 1]);
      await isolateInterpreter?.run(input, output);

      return output[0][0];
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
      return null;
    }
  }

  double minMaxScaler(double min, double max) {
    return 0.0;
  }
}

class TFLiteRunModel {
  final int gender;
  final int age;
  final double height;
  final double weight;
  final double duration; // в минутах
  final double avgHeartRate;

  TFLiteRunModel({
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.duration,
    required this.avgHeartRate,
  });
}
