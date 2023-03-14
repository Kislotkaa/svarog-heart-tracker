import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/helper/screan_helper.dart';
import 'package:svarog_heart_tracker/app/resourse/app_colors.dart';
import 'package:svarog_heart_tracker/app/resourse/app_const.dart';
import 'package:svarog_heart_tracker/app/resourse/app_theme.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button_text.dart';
import 'package:svarog_heart_tracker/app/widgets/base_text_form_widget.dart';

import '../controllers/admin_panel_controller.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  const AdminPanelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryConst,
      body: Center(
        child: SizedBox(
          width: isMobile ? double.infinity : Get.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'appIcon.svg',
                child: SvgPicture.asset(
                  'assets/images/appIcon.svg',
                  height: 200,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Администратор',
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).backgroundColor),
              ),
              SizedBox(height: Get.height * 0.08),
              BaseTextFieldWidget(
                height: 60,
                controller: controller.password,
                titleCenter: true,
                title: 'Пароль администратора',
              ),
              SizedBox(height: Get.height * 0.3),
              BaseButton(
                reverseColor: true,
                onPressed: () => controller.loginAdmin(),
                child: BaseButtonText(
                  'Войти',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
      ).paddingAll(AppConst.paddingAll),
    );
  }
}
