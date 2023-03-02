import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_button.dart';
import 'base_button_text.dart';
import 'base_text_form_widget.dart';

void showBaseDialog(
  String? title,
  String? text,
  Function()? onTapConfirm,
  Function()? onTapCancel,
  String? textConfirm,
  String? textCancel,
) {
  Get.defaultDialog(
    title: title ?? 'title',
    middleText: text ?? 'text',
    backgroundColor: Theme.of(Get.context!).backgroundColor,
    titleStyle: Theme.of(Get.context!).textTheme.headline4,
    middleTextStyle: Theme.of(Get.context!).textTheme.bodyText2,
    contentPadding:
        const EdgeInsets.only(top: 8, right: 16, bottom: 16, left: 16),
    titlePadding: const EdgeInsets.only(top: 16),
    radius: 16,
    confirm: BaseButton(
      onPressed: onTapConfirm,
      child: BaseButtonText(
        textConfirm ?? 'textConfirm',
      ),
    ),
    cancel: BaseButton(
      isOutLine: true,
      onPressed: onTapCancel,
      child: BaseButtonText(
        textCancel ?? 'textCancel',
        isOutLine: true,
        style: Theme.of(Get.context!).textTheme.bodyText2,
      ),
    ),
  );
}

void showBaseAddNameDialog(
  String? title,
  TextEditingController? controller,
  Function()? onTapConfirm,
  Function()? onTapCancel,
  String? textConfirm,
  String? textCancel,
) {
  Get.defaultDialog(
    content: BaseTextFieldWidget(
      textAlign: TextAlign.center,
      controller: controller,
      hintText: 'Введите имя тут...',
      titleCenter: true,
      autocorrect: false,
      autofocus: false,
      isAccentTitle: true,
      maxLines: 1,
    ),
    title: title ?? 'title',
    backgroundColor: Theme.of(Get.context!).backgroundColor,
    titleStyle: Theme.of(Get.context!).textTheme.headline4,
    middleTextStyle: Theme.of(Get.context!).textTheme.bodyText2,
    contentPadding:
        const EdgeInsets.only(top: 8, right: 16, bottom: 16, left: 16),
    titlePadding: const EdgeInsets.only(top: 16),
    radius: 16,
    confirm: BaseButton(
      onPressed: onTapConfirm,
      child: BaseButtonText(
        textConfirm ?? 'textConfirm',
      ),
    ),
    cancel: BaseButton(
      isOutLine: true,
      onPressed: onTapCancel,
      child: BaseButtonText(
        textCancel ?? 'textCancel',
        isOutLine: true,
        style: Theme.of(Get.context!).textTheme.bodyText2,
      ),
    ),
  );
}
