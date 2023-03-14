import 'package:get/get.dart';

import '../controllers/admin_set_password_controller.dart';

class AdminSetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSetPasswordController>(
      () => AdminSetPasswordController(
        startAppCache: Get.find(),
      ),
    );
  }
}
