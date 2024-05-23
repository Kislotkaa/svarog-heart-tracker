import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:svarog_heart_tracker/core/models/global_settings_model.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/insert_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/get_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/get_user_history_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_history/insert_user_history_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/get_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/insert_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/service/tflite_service.dart';
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
    required this.tfLiteService,
    required this.insertUserUseCase,
    required this.getHistoryByPkUseCase,
    required this.insertHistoryUseCase,
    required this.getUserByPkUseCase,
    required this.getUserSettingsByPkUseCase,
    required this.insertUserSettingsByPkUseCase,
    required this.getUserDetailByPkUseCase,
  });

  late UserSettingsModel userSettings;
  late UserModel? user;

  final BluetoothDevice device;
  final TFLiteService tfLiteService;
  final GetUserSettingsByPkUseCase getUserSettingsByPkUseCase;
  final GetUserDetailByPkUseCase getUserDetailByPkUseCase;
  final GetUserByPkUseCase getUserByPkUseCase;
  final GetUserHistoryByPkUseCase getHistoryByPkUseCase;
  final InsertUserHistoryUseCase insertHistoryUseCase;
  final InsertUserUseCase insertUserUseCase;
  final InsertUserSettingsByPkUseCase insertUserSettingsByPkUseCase;

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

  Future<void> onInit() async {
    await getAndSaveUser();
    await getServiceDevice();
  }

  Future<void> onDispose() async {
    try {
      await _unSubscribeCharacteristics();
      await saveHeartRateDB(ignoreTimer: true, isEnd: true);
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

        /// Сжимаем данные что бы оптимизировать список
        if (user != null) {
          final failurOrDetail = await getUserDetailByPkUseCase(user!.id);
          UserDetailModel? detail;
          failurOrDetail.fold((l) {}, (detailRequared) {
            if (detailRequared != null) {
              detail = detailRequared;
            }
          });
          if (detail != null) {
            await tfLiteService.isolateCalculateCallory(detail!, history!);
          }
        }
      }

      final failurOrInserted = await insertHistoryUseCase(history!.copyWith(yHeart: yHeart));
      failurOrInserted.fold((l) {}, (r) {});
      listHeartRate.clear();
    }
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

  Future<void> getAndSaveUser() async {
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
      final failurOrUpdating = await insertUserSettingsByPkUseCase(userSettings);
      failurOrUpdating.fold((l) {}, (settings) {});
    }

    final params = UserParams(
      id: id,
      userDetailId: userModel?.userDetailId,
      userSettingsId: needUpdateSettingsId ? userSettings.id : userModel?.userSettingsId,
      deviceName: device.advName,
      personName: userModel?.personName ?? name,
      isAutoConnect: userModel?.isAutoConnect,
    );

    final failurOrUserReq = await insertUserUseCase(params);
    failurOrUserReq.fold((l) {}, (userRequared) {
      user = userRequared;
    });
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
