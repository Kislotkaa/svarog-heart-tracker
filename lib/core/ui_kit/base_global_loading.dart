import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_loading.dart';

class BaseGlobalLoading extends StatelessWidget {
  const BaseGlobalLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Center(
        child: Container(
          height: 100,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            boxShadow: [appTheme.cardShadow],
            border: Border.all(color: appTheme.cardColor),
          ),
          child: const BaseCircularProgressIndicator(),
        ),
      ),
    );
  }
}
