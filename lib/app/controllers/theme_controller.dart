import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../resourse/app_theme.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  static ThemeData get _light => AppTheme.lightTheme;
  static ThemeData get _dark => AppTheme.darkTheme;

  final _isDarkStorage = false.val('isLight');

  final Rx<ThemeData> theme = Rx<ThemeData>(_light);
  final RxBool isDark = RxBool(false);

  ThemeData currentTheme() => _isDarkStorage.val ? _dark : _light;

  Brightness? _brightness;

  void _setDark() {
    theme.value = _dark;

    isDark.value = true;
    _isDarkStorage.val = true;
    Get.changeTheme(theme.value);
    Get.forceAppUpdate();
    Get.appUpdate();
    setSystemUIOverlayStyle();
  }

  void setSystemUIOverlayStyle() {
    if (theme.value == _dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }

  void _setLight() {
    theme.value = _light;

    isDark.value = false;
    _isDarkStorage.val = false;
    Get.changeTheme(theme.value);
    Get.forceAppUpdate();
    Get.appUpdate();
    setSystemUIOverlayStyle();
  }

  void switchTheme() {
    if (theme.value == _dark) {
      _setLight();
    } else {
      _setDark();
    }
  }

  @override
  void onReady() {
    super.onReady();
    isDark.value = _isDarkStorage.val;
    if (isDark.value) {
      _setDark();
    } else {
      _setLight();
    }
  }
}
