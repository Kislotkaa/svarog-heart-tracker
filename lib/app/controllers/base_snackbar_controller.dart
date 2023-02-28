
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';
import '../resourse/base_icons_icons.dart';

class BaseSnackbarController extends GetxController {
  static BaseSnackbarController get to => Get.find<BaseSnackbarController>();

  void show(String text, String title, {required SnackStatusEnum status}) {
    if (!Get.isSnackbarOpen) {
      switch (status) {
        case SnackStatusEnum.warning:
          Get.rawSnackbar(
            boxShadows: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 25,
                spreadRadius: 0,
                color: Get.theme.primaryColor.withOpacity(0.12),
              )
            ],
            titleText: Text(
              title,
              style: Get.textTheme.bodyText2!.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
            messageText: Text(
              text,
              style: Get.textTheme.subtitle1!.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
            icon: const Icon(
              BaseIcons.warning_shield,
              color: AppColors.textColorLight,
            ),
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(AppConst.paddingAll),
            borderRadius: AppConst.borderRadius,
            backgroundColor: Get.theme.primaryColor,
            duration: const Duration(seconds: 2),
          );
          break;
        case SnackStatusEnum.access:
          Get.rawSnackbar(
            boxShadows: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 25,
                spreadRadius: 0,
                color: Get.theme.primaryColor.withOpacity(0.12),
              )
            ],
            titleText: Text(
              title,
              style: Get.textTheme.bodyText2!.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
            messageText: Text(
              text,
              style: Get.textTheme.subtitle1!.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
            icon: const Icon(
              Icons.check_rounded,
              color: AppColors.textColorLight,
            ),
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(AppConst.paddingAll),
            borderRadius: AppConst.borderRadius,
            backgroundColor: Get.theme.primaryColor,
            duration: const Duration(seconds: 2),
          );
          break;
        default:
          Get.rawSnackbar(
            boxShadows: [
              BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 25,
                spreadRadius: 0,
                color: Get.theme.primaryColor.withOpacity(0.12),
              )
            ],
            titleText: Text(
              title,
              style: Get.textTheme.bodyText2!.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
            messageText: Text(
              text,
              style: Get.textTheme.subtitle1!.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
            icon: null,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(AppConst.paddingAll),
            borderRadius: AppConst.borderRadius,
            backgroundColor: Get.theme.primaryColor,
            duration: const Duration(seconds: 2),
          );
          break;
      }
    } else {
      Get.closeAllSnackbars();
    }
  }
}

void showSnackbar(
  String text,
  String title, {
  SnackStatusEnum status = SnackStatusEnum.normal,
}) {
  BaseSnackbarController.to.show(text, title, status: status);
}

enum SnackStatusEnum { warning, access, normal }
