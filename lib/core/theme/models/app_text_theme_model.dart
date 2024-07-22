import 'package:flutter/painting.dart';

/// Модель содержит в себе кастомные шрифты, нужны для темы
/// --------------------
/// НАПРЯМУЮ ОТ СЮДА НЕ БРАТЬ, ПРОКИДЫВАТЬ ЧЕРЕЗ AppThemeFarfor и AppThemeModel
class AppTextTheme {
  final TextStyle headerExtrabold20;
  final TextStyle subheaderExtrabold18;
  final TextStyle buttonExtrabold16;
  final TextStyle bodySemibold16;
  final TextStyle captionExtrabold14;
  final TextStyle captionSemibold14;
  final TextStyle smallButtonExtrabold12;
  final TextStyle smallCaptionSemibold12;

  const AppTextTheme({
    required this.headerExtrabold20,
    required this.subheaderExtrabold18,
    required this.buttonExtrabold16,
    required this.bodySemibold16,
    required this.captionExtrabold14,
    required this.captionSemibold14,
    required this.smallButtonExtrabold12,
    required this.smallCaptionSemibold12,
  });

  AppTextTheme copyWith({
    required TextStyle headerExtrabold20,
    required TextStyle subheaderExtrabold18,
    required TextStyle buttonExtrabold16,
    required TextStyle captionExtrabold14,
    required TextStyle bodySemibold16,
    required TextStyle captionSemibold14,
    required TextStyle smallButtonExtrabold12,
    required TextStyle smallCaptionSemibold12,
  }) {
    return AppTextTheme(
      headerExtrabold20: headerExtrabold20,
      subheaderExtrabold18: subheaderExtrabold18,
      buttonExtrabold16: buttonExtrabold16,
      bodySemibold16: bodySemibold16,
      captionExtrabold14: captionExtrabold14,
      captionSemibold14: captionSemibold14,
      smallButtonExtrabold12: smallButtonExtrabold12,
      smallCaptionSemibold12: smallCaptionSemibold12,
    );
  }

  static AppTextTheme lerp(AppTextTheme begin, AppTextTheme end, double t) => AppTextTheme(
        /// ------ Новые ------
        smallCaptionSemibold12: begin.smallCaptionSemibold12
            .copyWith(color: Color.lerp(begin.smallCaptionSemibold12.color, end.smallCaptionSemibold12.color, t)),
        smallButtonExtrabold12: begin.smallButtonExtrabold12
            .copyWith(color: Color.lerp(begin.smallButtonExtrabold12.color, end.smallButtonExtrabold12.color, t)),
        captionSemibold14: begin.captionSemibold14
            .copyWith(color: Color.lerp(begin.captionSemibold14.color, end.captionSemibold14.color, t)),
        bodySemibold16:
            begin.bodySemibold16.copyWith(color: Color.lerp(begin.bodySemibold16.color, end.bodySemibold16.color, t)),
        captionExtrabold14: begin.captionExtrabold14
            .copyWith(color: Color.lerp(begin.captionExtrabold14.color, end.captionExtrabold14.color, t)),
        buttonExtrabold16: begin.buttonExtrabold16
            .copyWith(color: Color.lerp(begin.buttonExtrabold16.color, end.buttonExtrabold16.color, t)),
        subheaderExtrabold18: begin.subheaderExtrabold18
            .copyWith(color: Color.lerp(begin.subheaderExtrabold18.color, end.subheaderExtrabold18.color, t)),
        headerExtrabold20: begin.headerExtrabold20
            .copyWith(color: Color.lerp(begin.headerExtrabold20.color, end.headerExtrabold20.color, t)),
      );
}
