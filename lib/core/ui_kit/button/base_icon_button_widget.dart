import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseIconButtonWidget extends StatelessWidget {
  const BaseIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      padding: const EdgeInsets.all(16),
      color: appTheme.basicColor,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(appTheme.revertBasicColor),
      ),
      onPressed: () {
        HapticFeedback.lightImpact();
        onPressed.call();
      },
      icon: Icon(icon),
    );
  }
}
