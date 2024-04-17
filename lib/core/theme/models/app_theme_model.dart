import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/theme/models/app_text_theme_model.dart';

/// Модель содержит в себе кастомные цвета, нужны для темы
class AppThemeModel {
  /// Изменяемые цвета — при смене темы меняются (белый->черный)
  final Color basicColor;
  final Color revertBasicColor;
  final Color shadowColor;
  final Color grayColor;
  final Color scaffoldColor;
  final Color textColor;
  final Color revertTextColor;
  final Color cardColor;
  final Color infoColor;

  // Неизменяемые цвета — при переключении темы никак не меняются
  final Color alwaysBlackTextColor;
  final Color alwaysWhiteTextColor;
  final Color alwaysBlackColor;
  final Color alwaysWhiteColor;
  final Color textGrayColor;
  final Color primaryColor;
  final Color errorColor;
  final Color yellowColor;
  final Color blueColor;
  final Color greenColor;
  final Color violetColor;
  final Color peachColor;

  // ТЕНИ
  final BoxShadow footerShadow;
  final BoxShadow cardShadow;

  // СИСТЕМНЫЕ
  final Brightness brightness;

  // ТЕКС
  final AppTextTheme textTheme;

  factory AppThemeModel({
    required Color cardColor,
    required Color grayColor,
    required Color shadowColor,
    required Color alwaysBlackText,
    required Color alwaysWhiteText,
    required Color alwaysBlack,
    required Color alwaysWhite,
    required Color textGray,
    required Color scaffoldColor,
    required Color textColor,
    required Color revertTextColor,
    required Color primaryColor,
    required Color errorColor,
    required Color yellowColor,
    required Color blueColor,
    required Color greenColor,
    required Color violetColor,
    required Color peachColor,
    required Color basicColor,
    required Color revertBasicColor,
    required Color infoColor,
    required BoxShadow footerShadow,
    required BoxShadow cardShadow,
    required Brightness brightness,
    required AppTextTheme textTheme,
  }) {
    return AppThemeModel.raw(
      cardColor: cardColor,
      grayColor: grayColor,
      shadowColor: shadowColor,
      alwaysBlackTextColor: alwaysBlackText,
      alwaysWhiteTextColor: alwaysWhiteText,
      alwaysBlackColor: alwaysBlack,
      alwaysWhiteColor: alwaysWhite,
      textGrayColor: textGray,
      scaffoldColor: scaffoldColor,
      textColor: textColor,
      revertTextColor: revertTextColor,
      primaryColor: primaryColor,
      errorColor: errorColor,
      yellowColor: yellowColor,
      blueColor: blueColor,
      greenColor: greenColor,
      revertBasicColor: revertBasicColor,
      basicColor: basicColor,
      cardShadow: cardShadow,
      footerShadow: footerShadow,
      brightness: brightness,
      textTheme: textTheme,
      violetColor: violetColor,
      peachColor: peachColor,
      infoColor: infoColor,
    );
  }

  const AppThemeModel.raw({
    required this.cardColor,
    required this.grayColor,
    required this.shadowColor,
    required this.alwaysBlackTextColor,
    required this.alwaysWhiteTextColor,
    required this.alwaysBlackColor,
    required this.alwaysWhiteColor,
    required this.textGrayColor,
    required this.scaffoldColor,
    required this.textColor,
    required this.revertTextColor,
    required this.primaryColor,
    required this.errorColor,
    required this.yellowColor,
    required this.blueColor,
    required this.greenColor,
    required this.violetColor,
    required this.peachColor,
    required this.textTheme,
    required this.basicColor,
    required this.revertBasicColor,
    required this.footerShadow,
    required this.cardShadow,
    required this.brightness,
    required this.infoColor,
  });

  static AppThemeModel lerp(AppThemeModel begin, AppThemeModel end, double t) {
    return AppThemeModel(
      cardColor: Color.lerp(begin.cardColor, end.cardColor, t)!,
      grayColor: Color.lerp(begin.grayColor, end.grayColor, t)!,
      shadowColor: Color.lerp(begin.shadowColor, end.shadowColor, t)!,
      alwaysBlackText: Color.lerp(begin.alwaysBlackTextColor, end.alwaysBlackTextColor, t)!,
      alwaysWhiteText: Color.lerp(begin.alwaysWhiteTextColor, end.alwaysWhiteTextColor, t)!,
      alwaysBlack: Color.lerp(begin.alwaysBlackColor, end.alwaysBlackColor, t)!,
      alwaysWhite: Color.lerp(begin.alwaysWhiteColor, end.alwaysWhiteColor, t)!,
      textGray: Color.lerp(begin.textGrayColor, end.textGrayColor, t)!,
      scaffoldColor: Color.lerp(begin.scaffoldColor, end.scaffoldColor, t)!,
      textColor: Color.lerp(begin.textColor, end.textColor, t)!,
      revertTextColor: Color.lerp(begin.revertTextColor, end.revertTextColor, t)!,
      primaryColor: Color.lerp(begin.primaryColor, end.primaryColor, t)!,
      errorColor: Color.lerp(begin.errorColor, end.errorColor, t)!,
      blueColor: Color.lerp(begin.blueColor, end.blueColor, t)!,
      yellowColor: Color.lerp(begin.yellowColor, end.yellowColor, t)!,
      greenColor: Color.lerp(begin.greenColor, end.greenColor, t)!,
      revertBasicColor: Color.lerp(begin.revertBasicColor, end.revertBasicColor, t)!,
      basicColor: Color.lerp(begin.basicColor, end.basicColor, t)!,
      violetColor: Color.lerp(begin.violetColor, end.violetColor, t)!,
      peachColor: Color.lerp(begin.peachColor, end.peachColor, t)!,
      infoColor: Color.lerp(begin.infoColor, end.infoColor, t)!,
      cardShadow: BoxShadow.lerp(begin.cardShadow, end.cardShadow, t)!,
      footerShadow: BoxShadow.lerp(begin.footerShadow, end.footerShadow, t)!,
      brightness: begin.brightness,
      textTheme: AppTextTheme.lerp(begin.textTheme, end.textTheme, t),
    );
  }
}
