import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_global_loading.dart';

import '../../../helper/screan_helper.dart';
import '../../../resourse/app_colors.dart';
import '../../../resourse/app_const.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_button_text.dart';
import '../../../widgets/base_text_form_widget.dart';
import '../controllers/admin_set_password_controller.dart';

class AdminSetPasswordView extends GetView<AdminSetPasswordController> {
  const AdminSetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryConst,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: isMobile ? double.infinity : Get.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseTextFieldWidget(
                    height: 60,
                    controller: controller.password,
                    titleCenter: true,
                    title: 'Пароль для входа',
                  ),
                  SizedBox(height: Get.height * 0.3),
                  BaseButton(
                    reverseColor: true,
                    onPressed: () => controller.setPassword(),
                    child: BaseButtonText(
                      'Установить',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
          ).paddingAll(AppConst.paddingAll),
          Obx(
            () => controller.isLoading.value ? BaseGlobalLoading() : SizedBox(),
          ),
        ],
      ),
    );
  }
}
