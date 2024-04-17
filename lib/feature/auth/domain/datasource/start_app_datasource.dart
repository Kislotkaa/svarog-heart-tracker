import 'package:shared_preferences/shared_preferences.dart';
import 'package:svarog_heart_tracker/core/constant/sprefs_keys.dart';
import 'package:svarog_heart_tracker/core/models/start_app_model.dart';

abstract class StartAppDataSource {
  StartAppModel? getData();
  Future<void> setData(StartAppModel params);
}

class StartAppDataSourceImpl extends StartAppDataSource {
  final SharedPreferences sharedPreferences;

  StartAppDataSourceImpl({required this.sharedPreferences});

  @override
  StartAppModel? getData() {
    final json = sharedPreferences.getString(SPrefsKeys.APP_START_KEY);
    if (json != null) {
      return StartAppModel.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> setData(StartAppModel params) async {
    await sharedPreferences.setString(SPrefsKeys.APP_START_KEY, params.toJson());

    throw UnimplementedError();
  }
}
