import 'package:flutter/material.dart';

enum ScreenSize {
  mobile,
  table;

  static ScreenSize current(final BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return ScreenSize.mobile;
    }

    return ScreenSize.table;
  }

  static bool isMobile(final BuildContext context) {
    switch (current(context)) {
      case ScreenSize.mobile:
        return true;
      default:
        return false;
    }
  }
}

class AppScreenSize {}
