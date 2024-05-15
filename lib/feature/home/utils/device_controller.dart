import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/utils/characteristic.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';
import 'package:uuid/uuid.dart';

class DeviceController {
  DeviceController({
    required this.id,
    required this.device,
    required this.name,
    required this.insertUserUseCase,
    required this.getHistoryByPkUseCase,
    required this.insertHistoryUseCase,
    required this.getUserByPkUseCase,
  });

  final BluetoothDevice device;

  final GetUserByPkUseCase getUserByPkUseCase;
  final GetUserHistoryByPkUseCase getHistoryByPkUseCase;
  final InsertUserHistoryUseCase insertHistoryUseCase;
  final InsertUserUseCase insertUserUseCase;

  final String name;
  final String id;
  final String idTraining = const Uuid().v4();

  int heartDifference = 0;
  int seconds = 0;

  int realHeart = 0;
  int avgHeart = 0;
  int maxHeart = 0;
  int minHeart = 0;

  int secondsOff = 0;
  int secondsRed = 0;
  int secondsOrange = 0;
  int secondsGreen = 0;

  final DateTime createAt = DateTime.now();

  List<int> listHeartRate = [];

  final stream = Stream.periodic(const Duration(milliseconds: 500)).asBroadcastStream();
  late List<BluetoothService> services = [];
  late StreamSubscription streamSubscription;

  Future<void> onInit() async {
    await getServiceDevice();
    await saveUser();
  }

  Future<void> onDispose() async {
    try {
      await _unSubscribeCharacteristics();
      await saveHeartRateDB(ignoreTimer: true);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  /// Отвечает за чтение характеристики датчика

  Future<void> getServiceDevice() async {
    try {
      services = await device.discoverServices();

      _getConsoleService(kDebugMode); // показать все доступные сервисы

      final BluetoothService? service = _getService(ble_service_tracker);
      final BluetoothCharacteristic? characteristic = _getCharacteristic(ble_character_heart_rate, service);
      await _subscribeCharacteristics(characteristic);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  /// Методы обработки и сохранения данных
  ///
  void setHeartDifference() {
    if (listHeartRate.length < 6) {
      return;
    }
    var preLast = listHeartRate[listHeartRate.length - 6];
    var last = listHeartRate.last;
    heartDifference = last - preLast;
  }

  void setHeartReal(List<int> value) {
    realHeart = getHeartRateAdaptive(value);
  }

  void saveHeartList() {
    if (realHeart != 0) {
      listHeartRate.add(realHeart);
    }
  }

  Future<void> saveTimeTraining(bool isSecond) async {
    if (isSecond) {
      if (realHeart == 0) {
        secondsOff++;
        if (secondsOff >= 20) {
          await saveHeartRateDB(ignoreTimer: true);
          sl<HomeBloc>().add(HomeRemoveDeviceEvent(blueDevice: device));
        }
      } else if (realHeart < 145) {
        secondsGreen++;
      } else if (realHeart < 160) {
        secondsOrange++;
      } else {
        secondsRed++;
      }
      seconds++;
    }
  }

  Future<void> saveHeartRateDB({bool ignoreTimer = false}) async {
    if (ignoreTimer && seconds > 180) {
      await _saveHeartRateDB();
    } else if (seconds % 180 == 0 && seconds != 0) {
      await _saveHeartRateDB();
    }
  }

  Future<void> _saveHeartRateDB() async {
    final failurOfHistory = await getHistoryByPkUseCase(idTraining);

    failurOfHistory.fold(
      (l) {},
      (history) async {
        DateTime finishedAt = DateTime.now();
        UserHistoryModel? model;
        if (history != null) {
          history.yHeart.addAll(listHeartRate);

          maxHeart = history.yHeart.max;
          minHeart = history.yHeart.min;
          avgHeart = history.yHeart.average.toInt();

          model = UserHistoryModel(
            id: history.id,
            userId: history.userId,
            yHeart: history.yHeart,
            avgHeart: avgHeart,
            maxHeart: maxHeart,
            minHeart: minHeart,
            redTimeHeart: secondsRed,
            orangeTimeHeart: secondsOrange,
            greenTimeHeart: secondsGreen,
            createAt: createAt,
            finishedAt: finishedAt,
          );
        } else {
          model = UserHistoryModel(
            id: idTraining,
            userId: id,
            yHeart: listHeartRate,
            avgHeart: listHeartRate.average.toInt(),
            maxHeart: listHeartRate.max,
            minHeart: listHeartRate.min,
            redTimeHeart: secondsRed,
            orangeTimeHeart: secondsOrange,
            greenTimeHeart: secondsGreen,
            createAt: createAt,
            finishedAt: finishedAt,
          );
        }
        final failurOrInserted = await insertHistoryUseCase(model);
        failurOrInserted.fold((l) {}, (r) {});
        listHeartRate.clear();
      },
    );
  }

  Future<List<int>?> getHistory() async {
    final failurOfHistory = await getHistoryByPkUseCase(idTraining);
    return failurOfHistory.fold(
      (l) {
        return null;
      },
      (history) {
        return history?.yHeart;
      },
    );
  }

  /// Вспомогательыне методы

  int getHeartRateAdaptive(List<int?>? value) {
    if (value != null) {
      return value[1] ?? 0;
    }
    return 0;
  }

  BluetoothService? _getService(String serviceId) {
    try {
      return services.firstWhereOrNull((element) => element.uuid.str128 == serviceId);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return null;
  }

  BluetoothCharacteristic? _getCharacteristic(
    String characteristicId,
    BluetoothService? serviceTracker,
  ) {
    try {
      if (serviceTracker != null) {
        return serviceTracker.characteristics.firstWhereOrNull((element) => element.uuid.str128 == characteristicId);
      }
      return null;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return null;
  }

  Future<void> _getConsoleService(bool isActive) async {
    try {
      if (isActive) {
        for (var service in services) {
          log('SERVICE_ID: ${service.uuid}');
          for (var characteristic in service.characteristics) {
            log('CHARACTERISTIC_ID: ${characteristic.uuid}');
            log('CHARACTERISTIC: ${await characteristic.read()}');
            log('CHARACTERISTIC_READ: ${String.fromCharCodes(await characteristic.read())}');
          }
        }
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> saveUser() async {
    final failurOrUser = await getUserByPkUseCase(id);

    late UserModel? userModel;
    failurOrUser.fold(
      (l) {
        userModel = null;
      },
      (user) {
        userModel = user;
      },
    );

    final params = UserParams(
      id: id,
      deviceName: device.advName,
      personName: userModel?.personName ?? name,
      isAutoConnect: userModel?.isAutoConnect,
    );

    final failurOrInserted = await insertUserUseCase(params);

    failurOrInserted.fold(
      (l) {
        log(l.toString());
      },
      (success) {
        log('success');
      },
    );
  }

  Future<void> _subscribeCharacteristics(
    BluetoothCharacteristic? characteristic,
  ) async {
    try {
      if (characteristic != null) {
        await characteristic.setNotifyValue(true);
        var isSecond = false;

        characteristic.onValueReceived.listen(setHeartReal);

        streamSubscription = stream.listen((event) async {
          saveHeartList(); // Запомнить текущий пульс

          setHeartDifference(); // Пульс уменьшается или увеличивается

          saveTimeTraining(isSecond); // Установить текущее время тренировки

          saveHeartRateDB(); // Запомнить текущий пульс

          isSecond = !isSecond;
        });
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _unSubscribeCharacteristics() async {
    await streamSubscription.cancel();
  }
}
