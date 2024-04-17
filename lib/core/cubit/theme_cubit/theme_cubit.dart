import 'dart:async';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/repository/theme_repository.dart';
import 'package:svarog_heart_tracker/core/theme/app_theme.dart';
import 'package:svarog_heart_tracker/core/theme/app_theme_data.dart';
import 'package:svarog_heart_tracker/core/theme/models/app_theme_model.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'theme_state.dart';

bool get isDarkMode => sl<ThemeCubit>().state.isDarkMode;
AppThemeModel get appTheme => sl<ThemeCubit>().state.appTheme ?? sl<ThemeCubit>().getAppTheme();

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository _themeRepository;
  late StreamSubscription<ThemeMode> _themeSubscription;

  ThemeCubit({
    required ThemeRepository themeRepository,
  })  : _themeRepository = themeRepository,
        super(const ThemeState()) {
    _listenTheme();
    emit(state.copyWith(appTheme: getAppTheme()));
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    _themeRepository.dispose();
    return super.close();
  }

  void _listenTheme() {
    _themeSubscription = _themeRepository.getTheme().listen(
      (customTheme) {
        if (customTheme.name == ThemeMode.light.name) {
          emit(state.copyWith(themeMode: ThemeMode.light, isDarkMode: false, appTheme: getLightAppTheme()));

          return;
        }

        if (customTheme.name == ThemeMode.dark.name) {
          emit(state.copyWith(themeMode: ThemeMode.dark, isDarkMode: true, appTheme: getDarkAppTheme()));
          return;
        }

        final brightness = PlatformDispatcher.instance.platformBrightness;

        if (brightness == Brightness.dark) {
          emit(state.copyWith(themeMode: ThemeMode.dark, isDarkMode: true, appTheme: getDarkAppTheme()));
        } else {
          emit(state.copyWith(themeMode: ThemeMode.light, isDarkMode: false, appTheme: getLightAppTheme()));
        }
      },
    );
  }

  void switchTheme() {
    if (isDarkMode) {
      _themeRepository.saveTheme(ThemeMode.light);
    } else {
      _themeRepository.saveTheme(ThemeMode.dark);
    }
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  ThemeData getLightThemeData() => AppThemeData.light;

  ThemeData getDarkThemeData() => AppThemeData.dark;

  AppThemeModel getLightAppTheme() => AppTheme.light;

  AppThemeModel getDarkAppTheme() => AppTheme.dark;

  AppThemeModel getAppTheme() => state.isDarkMode ? getDarkAppTheme() : getLightAppTheme();
}
