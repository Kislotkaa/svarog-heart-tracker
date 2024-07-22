import 'package:flutter/material.dart';

class AppStaticColors {
  const AppStaticColors._();

  // ЦВЕТА
  static const Color primary = Color.fromRGBO(12, 12, 12, 1);
  static const Color error = Color.fromRGBO(170, 34, 34, 1);
  static const Color green = Color.fromRGBO(0, 197, 102, 1);
  static const Color blue = Color.fromRGBO(57, 126, 255, 1);
  static const Color violet = Color.fromRGBO(116, 79, 146, 1);
  static const Color yellow = Color.fromRGBO(255, 203, 68, 1);
  static const Color peach = Color.fromRGBO(255, 237, 236, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color textGray = Color.fromRGBO(116, 124, 138, 1);

  // ТЕНИ (настраиваются точечно)

  // ГРАДИЕНТЫ (настраиваются точечно)
  static const LinearGradient bonusCardLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 121, 1, 1),
      Color.fromRGBO(254, 80, 0, 1),
    ],
  );
  static const LinearGradient violetPinkDiagonalLinearGradient = LinearGradient(
    begin: Alignment(-0, 1.5),
    end: Alignment(0.7, -1.3),
    colors: [
      AppStaticColors.violet,
      Color.fromRGBO(249, 0, 255, 1),
    ],
    stops: [
      0.0,
      0.9,
    ],
  );
  static const LinearGradient orangeDiagonalLinearGradient = LinearGradient(
    begin: Alignment(-0.3, 1.7),
    end: Alignment(0.7, -1.3),
    colors: [
      AppStaticColors.primary,
      Color.fromRGBO(254, 80, 0, 0.8),
    ],
    stops: [
      0.0,
      0.9,
    ],
  );
  static const LinearGradient darkDiagonalLinearGradient = LinearGradient(
    begin: Alignment(-0, 1.5),
    end: Alignment(0.7, -1.3),
    colors: [
      Color.fromRGBO(28, 30, 38, 1),
      Color.fromRGBO(28, 30, 38, 1),
    ],
    stops: [
      0.0,
      0.9,
    ],
  );
  static const LinearGradient orangePinkLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(255, 27, 136, 1),
      Color.fromRGBO(255, 72, 84, 1),
      Color.fromRGBO(255, 104, 35, 1),
    ],
  );
  static const LinearGradient redOrangeLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(254, 80, 0, 1),
      Color.fromRGBO(255, 135, 67, 1),
    ],
  );
  static const LinearGradient greenLightGreenLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 197, 102, 1),
      Color.fromRGBO(60, 218, 95, 1),
    ],
  );
  static const LinearGradient mastercardBlackLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(99, 94, 94, 1),
      Color.fromRGBO(52, 52, 52, 1),
    ],
  );

  static const LinearGradient visaBlueLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(52, 126, 213, 1),
      Color.fromRGBO(34, 95, 166, 1),
    ],
  );

  static const LinearGradient unknownCardPurpleLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(60, 46, 151, 1),
      Color.fromRGBO(107, 91, 208, 1),
    ],
  );

  static const LinearGradient greenNormalLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 197, 102, 1),
      Color.fromRGBO(109, 195, 0, 1),
    ],
  );

  static const LinearGradient greenYellowLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(3, 192, 75, 1),
      Color.fromRGBO(150, 222, 0, 1),
    ],
  );
  static const LinearGradient greenPresentLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(0, 195, 43, 1),
      Color.fromRGBO(0, 214, 08, 1),
    ],
  );
  static const LinearGradient violetPinkLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(144, 92, 255, 1),
      Color.fromRGBO(204, 50, 217, 1),
      Color.fromRGBO(255, 0, 184, 1),
    ],
  );

  static const LinearGradient violetLinearGradient = LinearGradient(
    colors: [
      Color.fromRGBO(151, 103, 253, 1),
      Color.fromRGBO(205, 103, 253, 1),
    ],
  );
}
