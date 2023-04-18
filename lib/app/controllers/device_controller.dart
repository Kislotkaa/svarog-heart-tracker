import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/helper/characteristic.dart';
import 'package:svarog_heart_tracker/app/helper/error_handler.dart';
import 'package:svarog_heart_tracker/app/modules/home/controllers/home_controller.dart';
import 'package:svarog_heart_tracker/app/repository/user_history_repository.dart';
import 'package:svarog_heart_tracker/app/repository/user_repository.dart';
import 'package:uuid/uuid.dart';

import '../models/user_history_model.dart';

class DeviceController extends GetxController {
  DeviceController({
    required this.device,
    required this.name,
    required this.id,
    required this.userHistoryRepository,
    required this.userRepository,
    required this.homeController,
  });

  final BluetoothDevice device;
  final UserHistoryRepository userHistoryRepository;
  final UserRepository userRepository;
  final HomeController homeController;

  final String name;
  final String id;
  final String idTraining = Uuid().v4();

  final RxInt heartDifference = 0.obs;
  final RxInt seconds = 0.obs;

  final RxInt realHeart = 0.obs;
  final RxInt avgHeart = 0.obs;
  final RxInt maxHeart = 0.obs;
  final RxInt minHeart = 0.obs;

  final RxInt secondsOff = 0.obs;
  final RxInt secondsRed = 0.obs;
  final RxInt secondsOrange = 0.obs;
  final RxInt secondsGreen = 0.obs;

  final DateTime createAt = DateTime.now();

  late List<int> listHeartRate = [];

  late List<BluetoothService> services = [];
  late StreamSubscription<dynamic> streamSubscription;

  /// Отвечает за чтение характеристики датчика

  Future<void> getServiceDevice() async {
    try {
      services = await device.discoverServices();
      BluetoothService? service;
      BluetoothCharacteristic? characteristic;
      BluetoothDescriptor? descriptor;

      _getConsoleService(false); // показать все доступные сервисы

      service = _getService(ble_service_tracker);
      characteristic = _getCharacteristic(ble_character_heart_rate, service);
      await _subscribeCharacteristics(characteristic);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  /// Методы обработки и сохранения данных
  ///
  void setHeartDifference() {
    try {
      var preLast = listHeartRate[listHeartRate.length - 6];
      var last = listHeartRate.last;
      if (preLast != null && last != null) {
        heartDifference.value = last - preLast;
      }
    } catch (e, s) {}
  }

  void setHeartReal(List<int?>? value) {
    if (value != null) {
      realHeart.value = getHeartRateAdaptive(value);
    }
  }

  void saveHeartList() {
    if (realHeart.value != 0) {
      listHeartRate.add(realHeart.value);
    }
  }

  Future<void> saveTimeTraining(bool isSecond) async {
    if (isSecond) {
      if (realHeart.value == 0) {
        secondsOff.value++;
        if (secondsOff.value >= 20) {
          await saveHeartRateDB(ignoreTimer: true);
          homeController.disconectDevice(device);
        }
      } else if (realHeart.value < 145) {
        secondsGreen.value++;
      } else if (realHeart.value < 160) {
        secondsOrange.value++;
      } else {
        secondsRed.value++;
      }
      seconds.value++;
      Get.printInfo(info: seconds.value.toString());
    }
  }

  Future<void> saveHeartRateDB({bool ignoreTimer = false}) async {
    try {
      if (ignoreTimer && seconds.value > 180) {
        await _saveHeartRateDB();
      } else if (seconds.value % 180 == 0 && seconds.value != 0) {
        await _saveHeartRateDB();
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _saveHeartRateDB() async {
    var result = await userHistoryRepository.getHistoryByPk(idTraining);
    DateTime finishedAt = DateTime.now();
    UserHistoryModel? model = null;
    if (result != null) {
      result.yHeart.addAll(listHeartRate);

      maxHeart.value = result.yHeart.max;
      minHeart.value = result.yHeart.min;
      avgHeart.value = result.yHeart.average.toInt();

      model = UserHistoryModel(
        id: result.id,
        userId: result.userId,
        yHeart: result.yHeart,
        avgHeart: avgHeart.value,
        maxHeart: maxHeart.value,
        minHeart: minHeart.value,
        redTimeHeart: secondsRed.value,
        orangeTimeHeart: secondsOrange.value,
        greenTimeHeart: secondsGreen.value,
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
        redTimeHeart: secondsRed.value,
        orangeTimeHeart: secondsOrange.value,
        greenTimeHeart: secondsGreen.value,
        createAt: createAt,
        finishedAt: finishedAt,
      );
    }
    await userHistoryRepository.insertHistory(model);
    listHeartRate.clear();
  }

  Future<List<int>?> getHistory() async {
    var result = await userHistoryRepository.getHistoryByPk(idTraining);
    return result?.yHeart;
  }

  /// Вспомогательыне методы

  int getHeartRateAdaptive(List<int?>? value) {
    try {
      if (value != null) {
        return value[1] ?? 0;
      }
    } catch (e, s) {}
    return 0;
  }

  BluetoothService? _getService(String serviceId) {
    try {
      return services
          .firstWhereOrNull((element) => element.uuid.toString() == serviceId);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  BluetoothCharacteristic? _getCharacteristic(
    String characteristicId,
    BluetoothService? serviceTracker,
  ) {
    try {
      if (serviceTracker != null) {
        return serviceTracker.characteristics.firstWhereOrNull(
            (element) => element.uuid.toString() == characteristicId);
      }
      return null;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _getConsoleService(bool isActive) async {
    try {
      if (isActive) {
        services.forEach((service) {
          Get.printInfo(info: 'SERVICE_ID: ${service.uuid}');
          service.characteristics.forEach((characteristic) async {
            Get.printInfo(info: 'CHARACTERISTIC_ID: ${characteristic.uuid}');
            Get.printInfo(
                info: 'CHARACTERISTIC: ${await characteristic.read()}');
            Get.printInfo(
                info:
                    'CHARACTERISTIC_READ: ${String.fromCharCodes(await characteristic.read())}');
          });
        });
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> saveUser() async {
    try {
      await userRepository.insertUser(id, name, device.name);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _subscribeCharacteristics(
    BluetoothCharacteristic? characteristic,
  ) async {
    final stream = Stream.periodic(const Duration(milliseconds: 500));
    if (characteristic != null) {
      await characteristic.setNotifyValue(true);
      var isSecond = false;

      streamSubscription = characteristic.value.listen((value) {
        setHeartReal(value); // Установить текущее значение пульса
      });

      streamSubscription = stream.listen((event) async {
        saveHeartList(); // Запомнить текущий пульс

        setHeartDifference(); // Пульс уменьшается или увеличивается

        saveTimeTraining(isSecond); // Установить текущее время тренировки

        saveHeartRateDB(); // Запомнить текущий пульс

        isSecond = !isSecond;
      });
    }
  }

  Future<void> _unSubscribeCharacteristics() async {
    try {
      await streamSubscription.cancel();
    } catch (e, s) {}
  }

  @override
  Future<void> onReady() async {
    await getServiceDevice();
    await saveUser();
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    await _unSubscribeCharacteristics();
    await saveHeartRateDB(ignoreTimer: true);
    super.onClose();
  }
}
