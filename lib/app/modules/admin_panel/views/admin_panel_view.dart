import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/helper/screan_helper.dart';
import 'package:svarog_heart_tracker/app/resourse/app_colors.dart';
import 'package:svarog_heart_tracker/app/resourse/app_const.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button_text.dart';
import 'package:svarog_heart_tracker/app/widgets/base_text_form_widget.dart';

import '../../../resourse/app_duration.dart';
import '../controllers/admin_panel_controller.dart';

class AdminPanelView extends GetView<AdminPanelController> {
  const AdminPanelView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.unFocus(context),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryConst,
          body: Obx(
            () => AnimatedCrossFade(
              firstChild: Center(
                child: SizedBox(
                  width: isMobile ? double.infinity : Get.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Obx(
                            () => AnimatedContainer(
                              height: controller.hasFocus.value ? 0 : 210,
                              duration: AppDuration.medium,
                              child: AnimatedOpacity(
                                duration: AppDuration.fast,
                                opacity: controller.hasFocus.value ? 0 : 1,
                                child: IgnorePointer(
                                  child: Hero(
                                    tag: 'appIcon.svg',
                                    child: SvgPicture.asset(
                                      'assets/images/appIcon.svg',
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Администратор',
                            style: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).backgroundColor),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.08),
                      BaseTextFieldWidget(
                        height: 60,
                        controller: controller.password,
                        titleCenter: true,
                        title: 'Пароль администратора',
                        maxLines: 1,
                        obscureText: true,
                        autocorrect: false,
                        onTap: () => controller.inFocus(),
                        onEditingComplete: () {
                          controller.unFocus(context);
                          TextInput.finishAutofillContext();
                        },
                        onSaved: (s) => controller.unFocus(context),
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
              secondChild: Center(
                child: SizedBox(
                  width: isMobile ? double.infinity : Get.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseTextFieldWidget(
                        height: 60,
                        controller: controller.password,
                        titleCenter: true,
                        title: 'Пароль',
                        autocorrect: false,
                        maxLines: 1,
                        onEditingComplete: () {
                          controller.unFocus(context);
                          TextInput.finishAutofillContext();
                        },
                        onSaved: (s) => controller.unFocus(context),
                      ),
                      const SizedBox(height: 16),
                      BaseTextFieldWidget(
                        height: 60,
                        controller: controller.repeatPassword,
                        titleCenter: true,
                        title: 'Повторите пароль',
                        autocorrect: false,
                        maxLines: 1,
                        onEditingComplete: () {
                          controller.unFocus(context);
                          TextInput.finishAutofillContext();
                        },
                        onSaved: (s) => controller.unFocus(context),
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
              crossFadeState: controller.crossState.value,
              duration: AppDuration.medium,
            ),
          )),
    );
  }
}
