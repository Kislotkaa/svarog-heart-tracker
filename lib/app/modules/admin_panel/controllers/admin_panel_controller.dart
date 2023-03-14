import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/base_snackbar_controller.dart';

import '../../../routes/app_pages.dart';

class AdminPanelController extends GetxController {
  final TextEditingController password = TextEditingController();

  late String? adminInstaller = '';

  @override
  Future<void> onInit() async {
    await dotenv.load(fileName: '.env');
    final env = dotenv.env;
    adminInstaller = env['APP_INSTAL'];
    super.onInit();
  }

  void loginAdmin() {
    if (password.text == adminInstaller) {
      Get.offAndToNamed(Routes.ADMIN_SET_PASSWORD);
    } else {
      showSnackbar(
        'Обратитесь к администратору за паролем',
        'Пароли не совпадают',
        status: SnackStatusEnum.error,
      );
    }
  }
}
