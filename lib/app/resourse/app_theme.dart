import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Robot',
    scaffoldBackgroundColor: AppColors.backGroundColorDark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(color: AppColors.textColorDark),
      actionsIconTheme: IconThemeData(color: AppColors.textColorDark),
      iconTheme: IconThemeData(color: AppColors.textColorDark),
    ),
    canvasColor: AppColors.grayColorDark,
    highlightColor: Colors.transparent,
    iconTheme: const IconThemeData(color: AppColors.textColorDark),
    primaryColorDark: AppColors.textColorDark,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: AppColors.textColorDark),
        ),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color.fromARGB(255, 19, 10, 2),
      circularTrackColor: Colors.transparent,
    ),
    primaryColor: AppColors.primaryConst,
    backgroundColor: AppColors.backGroundColorDark,
    dividerColor: AppColors.grayColorDark,
    cardColor: AppColors.darkGrayColorDark,
    hintColor: AppColors.darkGrayColorDark,
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorDark,
      ),
      subtitle2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.darkGrayColorDark,
      ),
      bodyText1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorDark,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorDark,
      ),
      headline1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorDark,
      ),
      headline2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textColorDark,
      ),
      headline3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorDark,
      ),
      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textColorDark,
      ),
      headline5: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorDark,
      ),
      headline6: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textColorDark,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.darkGrayColorDark,
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Robot',
    scaffoldBackgroundColor: AppColors.backGroundColorLight,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(color: AppColors.textColorLight),
      actionsIconTheme: IconThemeData(color: AppColors.textColorLight),
      iconTheme: IconThemeData(color: AppColors.textColorLight),
    ),
    primaryColorLight: AppColors.textColorLight,
    iconTheme: const IconThemeData(color: AppColors.textColorLight),
    primaryIconTheme: const IconThemeData(color: AppColors.textColorLight),
    highlightColor: Colors.transparent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: AppColors.textColorLight),
        ),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryConst,
      circularTrackColor: Colors.transparent,
    ),
    primaryColor: AppColors.primaryConst,
    backgroundColor: AppColors.backGroundColorLight,
    canvasColor: AppColors.grayColorLight,
    dividerColor: AppColors.grayColorLight,
    hintColor: AppColors.darkGrayColorLight,
    cardColor: AppColors.whiteConst,
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
      subtitle2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.darkGrayColorLight,
      ),
      bodyText1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
      headline1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
      headline2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textColorLight,
      ),
      headline3: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
      headline4: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textColorLight,
      ),
      headline5: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorLight,
      ),
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textColorLight,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.darkGrayColorLight,
      ),
    ),
  );
}
