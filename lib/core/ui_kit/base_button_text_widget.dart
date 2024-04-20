import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseButtonTextWidget extends StatelessWidget {
  const BaseButtonTextWidget(
    this.text, {
    Key? key,
    this.style,
    this.maxLines = 1,
    this.isOutLine = false,
  }) : super(key: key);
  final String text;
  final int maxLines;
  final bool isOutLine;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          (isOutLine == false
              ? appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.alwaysBlackTextColor)
              : appTheme.textTheme.bodySemibold16),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class AppColors {}
