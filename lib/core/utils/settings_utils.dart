import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/constant/sprefs_keys.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';

class SettingsUtils {
  final SharedPreferences prefs;

  const SettingsUtils(this.prefs);

  StartAppModel? getFirstStartApp() {
    var data = prefs.getString(SPrefsKeys.APP_START_KEY);
    if (data != null) {
      return StartAppModel.fromJson(data);
    }
    return null;
  }

  Future<void> setFirstStartApp(String string) async {
    await prefs.setString(SPrefsKeys.APP_START_KEY, string);
  }
}
