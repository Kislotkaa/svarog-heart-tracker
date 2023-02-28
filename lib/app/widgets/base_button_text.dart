import 'package:flutter/material.dart';

import '../resourse/app_colors.dart';

class BaseButtonText extends StatelessWidget {
  const BaseButtonText(
    this.text, {
    Key? key,
    this.style,
    this.maxLines,
    this.isOutLine = false,
  }) : super(key: key);
  final String text;
  final int? maxLines;
  final bool isOutLine;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          (isOutLine == false
              ? Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColors.textColorLight)
              : Theme.of(context).textTheme.bodyText2),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
