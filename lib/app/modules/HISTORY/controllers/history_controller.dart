import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/bluetooth_contoller.dart';
import 'package:svarog_heart_tracker/app/helper/error_handler.dart';
import 'package:svarog_heart_tracker/app/models/user_model.dart';
import 'package:svarog_heart_tracker/app/modules/home/controllers/home_controller.dart';

import '../../../controllers/device_controller.dart';
import '../../../repository/user_history_repository.dart';
import '../../../repository/user_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/base_dialog.dart';

class HistoryController extends GetxController {
  HistoryController({
    required this.bluetoothController,
    required this.userRepository,
    required this.userHistoryRepository,
  });

  final BluetoothController bluetoothController;

  final UserRepository userRepository;
  final UserHistoryRepository userHistoryRepository;

  final RxList<UserModel?> users = RxList<UserModel>();
  final List<BluetoothDevice?> connectedDevice = [];

  final RxBool isLoading = false.obs;

  void goToBack() {
    Get.back(closeOverlays: true);
  }

  Future<void> goToDetailHistory(String? id) async {
    if (id != null) {
      await Get.toNamed(Routes.HISTORY_DETAIL, arguments: id)
          ?.then((value) async {
        await getHistory();
      });
    }
  }

  Future<void> getHistory() async {
    try {
      isLoading.value = true;

      var resultUser = await userRepository.getUsers();
      users.clear();
      users.addAll(resultUser);

      var resultConnected = await bluetoothController.getConnectedDevices();
      connectedDevice.clear();
      connectedDevice.addAll(resultConnected);

      users.refresh();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  bool isConnected(String? id) {
    if (id != null) {
      var result =
          connectedDevice.firstWhereOrNull((element) => element?.id.id == id);
      return result == null ? false : true;
    }
    return false;
  }

  Future<bool> onDeleteUser(String? id) async {
    if (id != null) {
      var result = await showBaseDialog(
        'Разорвать соединение?',
        'Вы действительно хотите разорвать соединение?',
        () async {
          users.removeWhere((element) => element?.id == id);
          Get.delete<DeviceController>(tag: id);
          var resultHistory =
              await userHistoryRepository.getHistoryUserByPk(id);
          resultHistory.forEach((element) async {
            if (element?.id != null) {
              userHistoryRepository.removeHistoryByPk(element!.id);
            }
          });
          userRepository.removeUserByPk(id);
          var resultDevice = await bluetoothController.getConnectedDevices();
          var device =
              resultDevice.firstWhereOrNull((element) => element.id.id == id);
          if (device != null) bluetoothController.disconnectDevice(device);
          users.refresh();

          Get.back(result: true);
        },
        () {
          Get.back(result: false);
        },
        'Подтвердить',
        'Отмена',
      );
      return result;
    } else {
      return false;
    }
  }

  @override
  Future<void> onInit() async {
    await getHistory();
    super.onInit();
  }
}
