import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/constant/sprefs_keys.dart';

class GlobalSettingsDataSourceImpl {
  final SharedPreferences sharedPreferences;

  GlobalSettingsDataSourceImpl({required this.sharedPreferences});

  bool getMigratedHive() {
    final result = sharedPreferences.getBool(SPrefsKeys.IS_MIGRATED_HIVE);
    if (result != null) {
      return result;
    }
    return false;
  }

  Future<void> setMigratedHive(bool params) async {
    await sharedPreferences.setBool(SPrefsKeys.IS_MIGRATED_HIVE, params);
  }

  Future<void> clearData() async {
    await sharedPreferences.remove(SPrefsKeys.IS_MIGRATED_HIVE);
  }
}
