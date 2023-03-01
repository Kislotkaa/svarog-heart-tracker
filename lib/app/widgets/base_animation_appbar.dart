import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';
import '../resourse/app_shadow.dart';
import '../resourse/base_icons_icons.dart';

class BaseAppBar extends StatelessWidget {
  const BaseAppBar({
    Key? key,
    this.leftChild,
    this.height = 68,
    this.rightChild,
    this.titleAlight = TextAlign.center,
    this.onTapBack,
    this.title,
    this.backgroundColor = true,
    this.boxShadow,
  }) : super(key: key);

  final Widget? leftChild;
  final String? title;
  final double? height;
  final Widget? rightChild;
  final TextAlign? titleAlight;
  final bool backgroundColor;
  final List<BoxShadow>? boxShadow;

  final Function()? onTapBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConst.paddingAll,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor
            ? Theme.of(context).cardColor
            : Colors.red.withOpacity(0),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(
            AppConst.borderRadius,
          ),
        ),
        boxShadow: boxShadow ?? [AppShadow.shadowTextFieldLight],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftChild ?? SizedBox(),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title ?? '<Заголовок>',
              textAlign: titleAlight,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline2,
            ).paddingOnly(right: 12, left: 12),
          ),
          rightChild ?? const SizedBox(),
        ],
      ),
    );
  }
}
