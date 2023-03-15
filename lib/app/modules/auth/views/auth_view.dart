import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../helper/screan_helper.dart';
import '../../../resourse/app_const.dart';
import '../../../resourse/app_duration.dart';
import '../../../widgets/base_button.dart';
import '../../../widgets/base_button_text.dart';
import '../../../widgets/base_global_loading.dart';
import '../../../widgets/base_text_form_widget.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.unFocus(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                width: isMobile ? double.infinity : Get.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      'Сварог',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: Get.height * 0.08),
                    BaseTextFieldWidget(
                      height: 60,
                      controller: controller.password,
                      titleCenter: true,
                      title: 'Пароль',
                      autocorrect: false,
                      obscureText: true,
                      onTap: () => controller.inFocus(),
                      onEditingComplete: () {
                        controller.unFocus(context);
                        TextInput.finishAutofillContext();
                      },
                      onSaved: (s) => controller.unFocus(context),
                    ),
                    SizedBox(height: Get.height * 0.3),
                    BaseButton(
                      onPressed: () => controller.login(),
                      child: const BaseButtonText('Войти'),
                    )
                  ],
                ),
              ),
            ).paddingAll(AppConst.paddingAll),
            Obx(
              () =>
                  controller.isLoading.value ? BaseGlobalLoading() : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
