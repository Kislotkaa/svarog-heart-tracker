import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';

class BaseCircularProgressIndicatorWidget extends StatelessWidget {
  const BaseCircularProgressIndicatorWidget({
    Key? key,
    this.padding,
  }) : super(key: key);

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Center(
        child: CircularProgressIndicator(
          color: appTheme.textColor,
        ),
      ),
    );
  }
}
