import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseSettingsWidget extends StatelessWidget {
  const BaseSettingsWidget({
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
        onTap: () => onTap?.call(),
        child: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: appTheme.cardColor,
            boxShadow: [appTheme.cardShadow],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leftWidget,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: appTheme.textTheme.captionSemibold14.copyWith(color: textColor ?? appTheme.textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              rightWidget ?? const SizedBox(),
            ],
          ),
        ));
  }
}
