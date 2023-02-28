import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/app/resourse/app_colors.dart';

class AppShadow {
  static BoxShadow shadowTextFieldLight = BoxShadow(
    blurRadius: 24,
    spreadRadius: -20,
    offset: const Offset(0, 8),
    color: AppColors.shadowColorLight,
  );
  static BoxShadow shadowAccentLight = BoxShadow(
    blurRadius: 24,
    spreadRadius: -14,
    offset: const Offset(0, 8),
    color: AppColors.shadowColorLight,
  );
  static BoxShadow shadowAccentDark = BoxShadow(
    blurRadius: 24,
    spreadRadius: -14,
    offset: const Offset(0, 8),
    color: AppColors.shadowColorDark,
  );
  static BoxShadow shadowTextFieldDark = BoxShadow(
    blurRadius: 24,
    spreadRadius: -20,
    offset: const Offset(0, 8),
    color: AppColors.shadowColorDark,
  );

  static BoxShadow shadowTopLight = BoxShadow(
    offset: const Offset(0, 10),
    blurRadius: 18,
    spreadRadius: 2,
    color: AppColors.shadowColorLight,
  );
  static BoxShadow shadowTopDark = BoxShadow(
    offset: const Offset(0, 10),
    blurRadius: 18,
    spreadRadius: 2,
    color: AppColors.shadowColorDark,
  );
}
