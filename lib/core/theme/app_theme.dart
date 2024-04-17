import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/theme/colors/app_colors.dart';
import 'package:svarog_heart_tracker/core/theme/models/app_text_theme_model.dart';
import 'package:svarog_heart_tracker/core/theme/models/app_theme_model.dart';

class AppTheme {
  static final AppThemeModel light = AppThemeModel(
    // МЕНЯЮЩИЕСЯ ЦВЕТА
    scaffoldColor: AppDarkColors.text,
    basicColor: AppStaticColors.white,
    revertBasicColor: AppStaticColors.black,
    textColor: AppLightColors.text,
    grayColor: AppLightColors.gray,
    revertTextColor: AppDarkColors.text,
    shadowColor: AppLightColors.shadow,
    cardColor: AppLightColors.card,
    infoColor: AppStaticColors.black,

    // НЕ МЕНЯЮЩИЕСЯ ЦВЕТА
    alwaysBlackText: AppLightColors.text,
    alwaysWhiteText: AppDarkColors.text,
    alwaysBlack: AppStaticColors.black,
    alwaysWhite: AppStaticColors.white,
    primaryColor: AppStaticColors.primary,
    errorColor: AppStaticColors.error,
    yellowColor: AppStaticColors.yellow,
    blueColor: AppStaticColors.blue,
    greenColor: AppStaticColors.green,
    violetColor: AppStaticColors.violet,
    peachColor: AppStaticColors.peach,
    textGray: AppStaticColors.textGray,

    // ТЕНИ
    footerShadow: AppLightColors.footerShadow,
    cardShadow: AppLightColors.cardShadow,

    // СИСТЕМНЫЕ
    brightness: Brightness.light,

    // ТЕКСТ
    textTheme: const AppTextTheme(
      headerExtrabold20: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
      ),
      subheaderExtrabold18: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 18,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
      ),
      bodySemibold16: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
      ),
      buttonExtrabold16: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
      ),
      captionExtrabold14: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
      ),
      captionSemibold14: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
      ),
      smallButtonExtrabold12: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
      ),
      smallCaptionSemibold12: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
      ),
    ),
  );

  static final AppThemeModel dark = AppThemeModel(
    // МЕНЯЮЩИЕСЯ ЦВЕТА
    scaffoldColor: AppStaticColors.black,
    basicColor: AppStaticColors.black,
    revertBasicColor: AppStaticColors.white,
    textColor: AppDarkColors.text,
    grayColor: AppDarkColors.gray,
    revertTextColor: AppLightColors.text,
    shadowColor: AppDarkColors.shadow,
    cardColor: AppDarkColors.card,
    infoColor: AppLightColors.text,

    // НЕ МЕНЯЮЩИЕСЯ ЦВЕТА
    alwaysBlackText: AppLightColors.text,
    alwaysWhiteText: AppDarkColors.text,
    alwaysBlack: AppStaticColors.black,
    alwaysWhite: AppStaticColors.white,
    primaryColor: AppStaticColors.primary,
    errorColor: AppStaticColors.error,
    yellowColor: AppStaticColors.yellow,
    blueColor: AppStaticColors.blue,

    greenColor: AppStaticColors.green,
    violetColor: AppStaticColors.violet,
    peachColor: AppStaticColors.peach,
    textGray: AppStaticColors.textGray,

    // ТЕНИ
    footerShadow: AppDarkColors.footerShadow,
    cardShadow: AppDarkColors.cardShadow,

    // СИСТЕМНЫЕ
    brightness: Brightness.dark,

    // ТЕКСТ

    textTheme: const AppTextTheme(
      headerExtrabold20: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.text,
      ),
      subheaderExtrabold18: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 18,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.text,
      ),
      bodySemibold16: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: AppDarkColors.text,
      ),
      buttonExtrabold16: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.text,
      ),
      captionExtrabold14: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.text,
      ),
      captionSemibold14: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: AppDarkColors.text,
      ),
      smallButtonExtrabold12: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        height: 1.3,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.text,
      ),
      smallCaptionSemibold12: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: AppDarkColors.text,
      ),
    ),
  );
}
