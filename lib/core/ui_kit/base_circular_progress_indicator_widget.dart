import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseCircularProgressIndicatorWidget extends StatelessWidget {
  const BaseCircularProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: appTheme.textColor,
      ),
    );
  }
}

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
