import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_const.dart';
import '../resourse/app_shadow.dart';

class BaseSettings extends StatelessWidget {
  const BaseSettings({
    Key? key,
    required this.text,
    this.textColor,
    required this.leftWidget,
    this.rightWidget,
    this.onTap,
  }) : super(key: key);
  final String text;
  final Color? textColor;
  final Widget leftWidget;
  final Widget? rightWidget;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [AppShadow.shadowAccentLight],
          borderRadius: BorderRadius.circular(
            AppConst.borderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftWidget,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            rightWidget ?? const SizedBox(),
          ],
        ),
      ).paddingOnly(top: AppConst.paddingAll),
    );
  }
}
