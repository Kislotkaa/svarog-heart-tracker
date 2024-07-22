import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';

class BaseIconButtonWidget extends StatelessWidget {
  const BaseIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.margin,
  });
  final EdgeInsets? margin;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton.filled(
        padding: const EdgeInsets.all(16),
        color: appTheme.basicColor,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(appTheme.revertBasicColor),
        ),
        onPressed: () {
          HapticFeedback.lightImpact();
          onPressed.call();
        },
        icon: Icon(icon),
      ),
    );
  }
}
