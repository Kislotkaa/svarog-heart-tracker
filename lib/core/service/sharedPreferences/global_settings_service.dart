import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/constant/sprefs_keys.dart';
import 'package:svarog_heart_tracker/core/models/global_settings_model.dart';

class GlobalSettingsService {
  final SharedPreferences sharedPreferences;
  late GlobalSettingsModel appSettings = GlobalSettingsModel();

  GlobalSettingsService({required this.sharedPreferences});

  GlobalSettingsService init() {
    final result = sharedPreferences.getString(SPrefsKeys.GLOBAL_SETTINGS);
    if (result != null && result.isNotEmpty) {
      appSettings = GlobalSettingsModel.fromJson(result);
    }
    return this;
  }

  Future<void> updateSettings(GlobalSettingsModel model) async {
    appSettings = model;
    await sharedPreferences.setString(SPrefsKeys.GLOBAL_SETTINGS, model.toJson());
  }

  Future<void> setMigratedHive(bool flag) async {
    final settings = appSettings.copyWith(isMigratedHive: flag);
    await sharedPreferences.setString(SPrefsKeys.GLOBAL_SETTINGS, settings.toJson());
  }

  Future<GlobalSettingsModel> setToDefault() async {
    appSettings = GlobalSettingsModel(isMigratedHive: appSettings.isMigratedHive);
    await sharedPreferences.setString(SPrefsKeys.GLOBAL_SETTINGS, appSettings.toJson());
    return appSettings;
  }
}
