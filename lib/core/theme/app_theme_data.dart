import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svarog_heart_tracker/core/theme/colors/app_colors.dart';

class AppThemeData {
  static final ThemeData dark = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: AppStaticColors.black,
      iconTheme: const IconThemeData(
        color: AppStaticColors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppStaticColors.black,
      color: AppStaticColors.white,
    ),
    dividerColor: AppDarkColors.gray,
    brightness: Brightness.dark,
    unselectedWidgetColor: AppDarkColors.text,
    iconTheme: const IconThemeData(color: AppDarkColors.text),
    shadowColor: AppDarkColors.shadow,
    hintColor: AppStaticColors.textGray,
    disabledColor: AppStaticColors.textGray,
    scaffoldBackgroundColor: AppStaticColors.black,
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 13.0,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppStaticColors.black,
      unselectedItemColor: AppStaticColors.textGray,
      selectedItemColor: AppStaticColors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
    ),
  );

  static final ThemeData light = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: AppStaticColors.white,
      iconTheme: const IconThemeData(
        color: AppLightColors.text,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppStaticColors.white,
      color: AppStaticColors.black,
    ),
    brightness: Brightness.light,
    dividerColor: AppLightColors.gray,
    unselectedWidgetColor: AppLightColors.text,
    iconTheme: const IconThemeData(color: AppLightColors.text),
    shadowColor: AppLightColors.shadow,
    scaffoldBackgroundColor: AppLightColors.gray,
    hintColor: AppStaticColors.textGray,
    disabledColor: AppStaticColors.textGray,
    inputDecorationTheme: const InputDecorationTheme(
      //filled: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 13.0,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppStaticColors.white,
      unselectedItemColor: AppStaticColors.textGray,
      selectedItemColor: AppLightColors.text,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppStaticColors.textGray,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppLightColors.text,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppStaticColors.white,
        fontStyle: FontStyle.normal,
      ),
    ),
  );
}
