import 'package:flutter/material.dart';

export 'app_farfor_colors.dart';

// Этот файлы содержит классы цветов которые меняются при смены темы AppDarkColors.text -> AppLightColors.text
class AppDarkColors {
  // ЦВЕТА
  static const Color shadow = Color.fromRGBO(145, 145, 145, 1);
  static const Color text = Color.fromRGBO(241, 244, 249, 1);
  static const Color gray = Color.fromRGBO(44, 47, 57, 1);
  static const Color card = Color.fromRGBO(28, 30, 38, 1);

  // ТЕНИ
  static BoxShadow footerShadow = BoxShadow(
    color: shadow.withOpacity(0.3),
    offset: const Offset(0, -6),
    blurRadius: 30,
  );

  static BoxShadow cardShadow = BoxShadow(
    color: shadow.withOpacity(0.08),
    offset: const Offset(0, 6),
    blurRadius: 30,
  );
}

/// Этот класс содержит в себе цвета для светлой темы
class AppLightColors {
  // ЦВЕТА
  static const Color shadow = Color.fromRGBO(50, 52, 72, 1);
  static const Color text = Color.fromRGBO(44, 47, 57, 1);
  static const Color gray = Color.fromRGBO(241, 244, 249, 1);
  static const Color card = Color.fromRGBO(255, 255, 255, 1);

  // ТЕНИ
  static BoxShadow footerShadow = BoxShadow(
    color: shadow.withOpacity(0.3),
    offset: const Offset(0, -6),
    blurRadius: 30,
  );

  static BoxShadow cardShadow = BoxShadow(
    color: shadow.withOpacity(0.08),
    offset: const Offset(0, 6),
    blurRadius: 30,
  );
}
