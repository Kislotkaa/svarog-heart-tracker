import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/resourse/app_strings.dart';
import 'package:svarog_heart_tracker/app/widgets/base_global_loading.dart';

import '../../../resourse/app_colors.dart';
import '../../../resourse/app_const.dart';
import '../../../resourse/base_icons_icons.dart';
import '../../../widgets/base_animation_appbar.dart';
import '../../../widgets/base_backgroudappbar.dart';
import '../../../widgets/base_settings.dart';
import '../../../widgets/base_title.dart';
import '../../../widgets/base_version.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = 68;

    return Scaffold(
      body: Stack(
        children: [
          BaseBackgroundAddBar(height: height),
          SafeArea(
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.only(top: height + 16),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BaseTitle(
                          title: 'История',
                        ),
                        BaseSettings(
                          onTap: () => controller.goToHistory(),
                          leftWidget: const Icon(BaseIcons.history),
                          text: 'История',
                          rightWidget:
                              const Icon(Icons.keyboard_arrow_right_rounded),
                        ),
                        Obx(
                          () => controller.sqlLiteController.isEmpty.value
                              ? const SizedBox()
                              : BaseSettings(
                                  onTap: () => controller.onTapDeleteHistory(),
                                  leftWidget: const Icon(
                                    BaseIcons.history,
                                    color: AppColors.redConst,
                                  ),
                                  text: 'Отчистить историю',
                                  textColor: AppColors.redConst,
                                ),
                        ),
                        const SizedBox(height: 16),
                        BaseTitle(
                          title: 'Дополнительные',
                        ),
                        BaseSettings(
                          onTap: () => controller.goToAbout(),
                          leftWidget: const Icon(BaseIcons.warning_shield),
                          text: 'О нас',
                        ),
                        BaseSettings(
                          onTap: () => controller.goToHowToUse(),
                          leftWidget: const Icon(Icons.question_mark),
                          text: 'Как пользоваться',
                        ),
                        BaseSettings(
                          onTap: () => controller.goToUrl(AppStrings.politUrl),
                          leftWidget: const Icon(
                            Icons.document_scanner_outlined,
                          ),
                          text: 'Политика конфиденциальности',
                        ),
                        const SizedBox(height: 16),
                        BaseTitle(
                          title: 'Аккаунт',
                        ),
                        BaseSettings(
                          onTap: () => controller.onTapLogout(),
                          leftWidget: const Icon(Icons.exit_to_app_rounded),
                          text: 'Выйти с аккаунта',
                        ),
                        BaseSettings(
                          onTap: () => controller.onTapDeleteAccount(),
                          leftWidget: const Icon(
                            Icons.close,
                            color: AppColors.redConst,
                          ),
                          text: 'Удалить аккаунт',
                          textColor: AppColors.redConst,
                        ),
                        const SizedBox(height: 32),
                        const BaseVersion(),
                      ],
                    ),
                  ],
                ).paddingSymmetric(horizontal: AppConst.paddingAll),
                BaseAppBar(
                  onTapBack: () => controller.goToBack(),
                  height: height,
                  titleAlight: TextAlign.start,
                  title: 'Настройки',
                  leftChild: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? const BaseGlobalLoading()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
