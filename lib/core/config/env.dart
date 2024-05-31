import 'package:svarog_heart_tracker/core/constant/constants.dart';
import 'package:svarog_heart_tracker/core/service/intl/models/language_model.dart';

class EnvironmentConfig {
  static const APP_PASSWORD = String.fromEnvironment('APP_PASSWORD');
  static const APP_POLIT_URL = String.fromEnvironment('APP_POLIT_URL');

  static final List<LanguageModel> languageOptions = [
    LanguageModel(key: IntlLocales.ru, value: 'Русский', english: 'Russian'),
    LanguageModel(key: IntlLocales.en, value: 'English', english: 'English'),
  ];
}
