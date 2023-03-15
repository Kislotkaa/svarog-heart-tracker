import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_global_loading.dart';

import '../../../resourse/app_colors.dart';
import '../../../resourse/app_const.dart';
import '../../../resourse/base_icons_icons.dart';
import '../../../widgets/base_animation_appbar.dart';
import '../../../widgets/base_backgroudappbar.dart';
import '../../../widgets/base_item_settings.dart';
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
                        // BaseTitle(
                        //   title: 'Основные',
                        //   style: Theme.of(context).textTheme.headline3,
                        // ),
                        // BaseItemSettings(
                        //   onTap: () => controller.swithTheme(),
                        //   leftWidget: const Icon(BaseIcons.moon),
                        //   text: 'Тема',
                        //   rightWidget: Switch(
                        //     activeColor: Theme.of(context).primaryColor,
                        //     onChanged: (bool value) => controller.swithTheme(),
                        //     value: controller.themeController.isDark.value,
                        //   ),
                        // ),
                        // const SizedBox(height: 16),
                        BaseTitle(
                          title: 'Дополнительные',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        BaseItemSettings(
                          onTap: () => controller.goToAbout(),
                          leftWidget: const Icon(BaseIcons.warning_shield),
                          text: 'О нас',
                        ),
                        const SizedBox(height: 16),
                        BaseTitle(
                          title: 'Аккаунт',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        BaseItemSettings(
                          onTap: () => controller.onTapLogout(),
                          leftWidget: const Icon(Icons.exit_to_app_rounded),
                          text: 'Выйти с аккаунта',
                        ),
                        BaseItemSettings(
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
