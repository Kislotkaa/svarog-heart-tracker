import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/constant/sprefs_keys.dart';
import 'package:svarog_heart_tracker/core/models/global_settings_model.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';

class GlobalSettingsService {
  final SharedPreferences sharedPreferences;
  late GlobalSettingsModel appSettings = GlobalSettingsModel();
  GlobalSettingsService({required this.sharedPreferences});

  Future<GlobalSettingsService> init() async {
    final result = sharedPreferences.getString(SPrefsKeys.GLOBAL_SETTINGS);
    if (result != null && result.isNotEmpty) {
      try {
        appSettings = GlobalSettingsModel.fromJson(result);
      } catch (e, s) {
        setToDefault();
        ErrorHandler.getMessage(e, s);
      }
    }
    return this;
  }

  Future<void> updateSettings(GlobalSettingsModel model) async {
    appSettings = model;
    await sharedPreferences.setString(SPrefsKeys.GLOBAL_SETTINGS, appSettings.toJson());
  }

  Future<void> setMigratedHive(bool flag) async {
    appSettings = appSettings.copyWith(isMigratedHive: flag);
    await sharedPreferences.setString(SPrefsKeys.GLOBAL_SETTINGS, appSettings.toJson());
  }

  Future<GlobalSettingsModel> setToDefault() async {
    appSettings = GlobalSettingsModel(isMigratedHive: appSettings.isMigratedHive);
    await sharedPreferences.setString(SPrefsKeys.GLOBAL_SETTINGS, appSettings.toJson());
    return appSettings;
  }
}
