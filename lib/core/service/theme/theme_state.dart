part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool isDarkMode;
  final AppThemeModel? appTheme;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.isDarkMode = false,
    this.appTheme,
  }); // Default theme = light theme

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isDarkMode,
    AppThemeModel? appTheme,
  }) =>
      ThemeState(
        themeMode: themeMode ?? this.themeMode,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        appTheme: appTheme ?? this.appTheme,
      );

  @override
  List<Object?> get props => [themeMode, isDarkMode, appTheme];
}
