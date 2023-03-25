import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/device_controller.dart';
import 'package:svarog_heart_tracker/app/helper/error_handler.dart';
import 'package:svarog_heart_tracker/app/models/user_history_model.dart';
import 'package:svarog_heart_tracker/app/repository/user_repository.dart';

import '../../../controllers/bluetooth_contoller.dart';
import '../../../models/user_model.dart';
import '../../../repository/user_history_repository.dart';
import '../../../widgets/base_dialog.dart';

class HistoryDetailController extends GetxController {
  HistoryDetailController({
    required this.bluetoothController,
    required this.userHistoryRepository,
    required this.userRepository,
  });
  final BluetoothController bluetoothController;
  final UserHistoryRepository userHistoryRepository;
  final UserRepository userRepository;

  final Rxn<UserModel?> user = Rxn<UserModel?>();
  late DeviceController? deviceController = null;
  final RxList<UserHistoryModel?> listHistory = RxList<UserHistoryModel>();

  final RxBool isLoading = false.obs;

  void goToBack() {
    Get.back(closeOverlays: true);
  }

  Future<void> swithAutoConnect() async {
    if (user.value != null) {
      var model = UserModel(
        id: user.value!.id,
        personName: user.value!.personName,
        deviceName: user.value!.deviceName,
        isAutoConnect: !user.value!.isAutoConnect,
      );
      await userRepository.updateUserByPk(model);
      await getUser(Get.arguments);
    }
  }

  Future<void> getDetailHistory() async {
    try {
      if (user.value?.id != null) {
        var result =
            await userHistoryRepository.getHistoryUserByPk(user.value!.id);
        listHistory.clear();
        listHistory.addAll(result);
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> getUser(String? id) async {
    try {
      if (id != null) {
        user.value = await userRepository.getUserByPk(id);
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> getDeviceController() async {
    try {
      if (user.value?.id != null) {
        deviceController = Get.find<DeviceController>(tag: user.value!.id);
      }
    } catch (e, s) {}
  }

  void onTapDeleteHistory() {
    showBaseDialog(
      'Отчистить историю тренировок?',
      'Вы действительно хотите удалить историю тренировок у пользователя?',
      () => deleteAllHistory(),
      () => Get.back(),
      'Подтвердить',
      'Отмена',
    );
  }

  Future<bool?> deleteHistory(String? id) async {
    try {
      if (id != null) {
        await userHistoryRepository.removeHistoryByPk(id);
        listHistory.removeWhere((element) => element?.id == id);
        return true;
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
      return false;
    }
  }

  Future<void> deleteAllHistory() async {
    try {
      listHistory.forEach((element) async {
        if (element?.id != null) {
          await userHistoryRepository.removeHistoryByPk(element!.id);
        }
      });
      listHistory.clear();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  @override
  Future<void> onInit() async {
    await getUser(Get.arguments);
    await getDetailHistory();
    await getDeviceController();

    super.onInit();
  }
}
