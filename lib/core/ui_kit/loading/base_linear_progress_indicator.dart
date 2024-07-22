import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';

class BaseLinearProgressIndicator extends StatelessWidget {
  const BaseLinearProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: appTheme.textColor,
      backgroundColor: Colors.transparent,
    );
  }
}
