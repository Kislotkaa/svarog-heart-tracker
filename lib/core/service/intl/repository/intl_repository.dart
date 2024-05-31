import 'dart:async';
import 'dart:io';

import 'package:svarog_heart_tracker/core/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IntlRepository {
  Stream<String> getLocale();
  Future saveLocale(String locale);
  void dispose();
}

class IntlRepositoryImpl implements IntlRepository {
  final SharedPreferences _prefs;

  IntlRepositoryImpl({
    required SharedPreferences sharedPreferences,
  }) : _prefs = sharedPreferences {
    _init();
  }

  final _controller = StreamController<String>();

  void _init() {
    try {
      final locale = _prefs.getString(INTL_LOCAL_KEY);

      if (locale == null) {
        final systemLocale = Platform.localeName;

        late final String locale;

        if (systemLocale.substring(0, 2) == IntlLocales.ru) {
          locale = IntlLocales.ru;
        } else {
          locale = IntlLocales.en;
        }

        _controller.add(locale);
        saveLocale(locale);
        return;
      }

      if (locale == IntlLocales.en) {
        _controller.add(IntlLocales.en);
        return;
      }

      _controller.add(IntlLocales.ru);
    } catch (_) {
      saveLocale(IntlLocales.ru);
    }
  }

  void _setValue(String themeName) => _prefs.setString(INTL_LOCAL_KEY, themeName);

  // async* и yield* - то же самое, что и async await, только для стрима
  @override
  Stream<String> getLocale() async* {
    yield* _controller.stream;
  }

  @override
  Future<void> saveLocale(String locale) async {
    _controller.add(locale);
    _setValue(locale);
  }

  @override
  void dispose() => _controller.close();
}
