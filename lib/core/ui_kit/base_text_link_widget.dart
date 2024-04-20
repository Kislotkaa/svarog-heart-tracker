import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseTextLinkWidget extends StatelessWidget {
  const BaseTextLinkWidget(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Text(
            text,
            style: appTheme.textTheme.bodySemibold16.copyWith(
              color: appTheme.blueColor,
            ),
          ),
          Container(
            height: 1,
            color: appTheme.blueColor,
          )
        ],
      ),
    );
  }
}
