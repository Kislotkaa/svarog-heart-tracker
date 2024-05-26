import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/models/global_settings_model.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/get_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/insert_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/utils/characteristic.dart';
import 'package:svarog_heart_tracker/core/utils/compress_data.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
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
    required this.getUserSettingsByPkUseCase,
    required this.insertUserSettingsByPkUseCase,
  });

  /// Для получения и обновления настроек пользователя
  final GetUserSettingsByPkUseCase getUserSettingsByPkUseCase;
  final InsertUserSettingsByPkUseCase insertUserSettingsByPkUseCase;
  late UserSettingsModel userSettings;

  /// Для обновления настроек пользователя
  final GetUserByPkUseCase getUserByPkUseCase;
  final InsertUserUseCase insertUserUseCase;

  /// Для работы с историями
  final GetUserHistoryByPkUseCase getHistoryByPkUseCase;
  final InsertUserHistoryUseCase insertHistoryUseCase;

  final BluetoothDevice device;
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

  final globalSettingsService = sl<GlobalSettingsService>();
  GlobalSettingsModel get appSettings => globalSettingsService.appSettings;

  /// Методы обработки и сохранения данных
  void setHeartDifference() {
    if (listHeartRate.length < 6) {
      return;
    }
    var preLast = listHeartRate[listHeartRate.length - 6];
    var last = listHeartRate.last;
    heartDifference = last - preLast;
  }

  void setHeartReal(List<int> value) {
    realHeart = value[1];
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
        if (secondsOff >= appSettings.timeDisconnect) {
          await saveHeartRateDB(ignoreTimer: true);
          sl<ConnectDeviceBloc>().add(ConnectDeviceDisconnectEvent(deviceController: this));
        }
      } else if (realHeart < userSettings.greenZone) {
        secondsGreen++;
      } else if (realHeart < userSettings.orangeZone) {
        secondsOrange++;
      } else {
        secondsRed++;
      }
      seconds++;
    }
  }

  Future<void> saveHeartRateDB({bool ignoreTimer = false, bool isEnd = false}) async {
    if (ignoreTimer && seconds > appSettings.timeSavedData) {
      await _saveHeartRateDB(isEnd: isEnd);
    } else if (seconds % appSettings.timeSavedData == 0 && seconds != 0) {
      await _saveHeartRateDB();
    }
  }

  Future<void> _saveHeartRateDB({bool isEnd = false}) async {
    final failurOfHistory = await getHistoryByPkUseCase(idTraining);

    UserHistoryModel? history;

    failurOfHistory.fold(
      (l) {},
      (historyRequared) async {
        DateTime finishedAt = DateTime.now();
        if (historyRequared != null) {
          historyRequared.yHeart.addAll(listHeartRate);

          maxHeart = historyRequared.yHeart.max;
          minHeart = historyRequared.yHeart.min;
          avgHeart = historyRequared.yHeart.average.toInt();

          history = UserHistoryModel(
            id: historyRequared.id,
            userId: historyRequared.userId,
            yHeart: historyRequared.yHeart,
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
          history = UserHistoryModel(
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
      },
    );

    if (history != null) {
      List<int> yHeart = history!.yHeart;

      if (isEnd) {
        /// Сжимаем данные что бы оптимизировать список
        yHeart = compressArray(yHeart);
      }

      final failurOrInserted = await insertHistoryUseCase(history!.copyWith(yHeart: yHeart));
      failurOrInserted.fold((l) {}, (r) {});
      listHeartRate.clear();
    }
  }

  /// Метод нужен что бы получить историю на экране главной активности
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

  Future<void> getAndSaveUser() async {
    /// Получаем модель пользователя подключения
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

    final userSettingsId = userModel?.userSettingsId;

    /// Получаем настройки пользователя
    bool needUpdateSettingsId = false;
    final failurOrSettings = await getUserSettingsByPkUseCase(userSettingsId ?? '');
    failurOrSettings.fold((l) {}, (model) {
      if (model == null) {
        userSettings = UserSettingsModel(id: const Uuid().v4());
        needUpdateSettingsId = true;
        return;
      }
      userSettings = model;
    });

    if (needUpdateSettingsId) {
      /// Если настроек нет то создадим их
      final failurOrUpdating = await insertUserSettingsByPkUseCase(userSettings);
      failurOrUpdating.fold((l) {}, (settings) {});

      /// сразу обнови settingsId у пользователя
      final failurOrUserReq = await insertUserUseCase(UserParams(
        id: id,
        userDetailId: userModel?.userDetailId,
        userSettingsId: needUpdateSettingsId ? userSettings.id : userModel?.userSettingsId,
        deviceName: device.advName,
        personName: userModel?.personName ?? name,
        isAutoConnect: userModel?.isAutoConnect,
      ));
      failurOrUserReq.fold((l) {}, (userRequared) {});
    }
  }

  Future<void> getServiceDevice() async {
    try {
      services = await device.discoverServices();

      _getConsoleService(kDebugMode); // показать все доступные сервисы

      final BluetoothService? service = services.firstWhereOrNull(
        (element) => element.uuid.str128 == ble_service_tracker,
      );

      final BluetoothCharacteristic? characteristic = service?.characteristics.firstWhereOrNull(
        (element) => element.uuid.str128 == ble_character_heart_rate,
      );

      await _subscribeCharacteristics(characteristic);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> onInit() async {
    await getAndSaveUser();
    await getServiceDevice();
  }

  Future<void> onDispose() async {
    try {
      await streamSubscription.cancel();
      await saveHeartRateDB(ignoreTimer: true, isEnd: true);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }
}
