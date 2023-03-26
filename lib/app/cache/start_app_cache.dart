import '../models/start_app_model.dart';
import 'abstarct_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartAppCache extends AbstractDataSource {
  @override
  String get key => 'first_start_app';

  @override
  Future<void> setData(param) async {
    await sharedPreferences?.setString(key, param);
    // return await box.write(key, param);
  }

  @override
  StartAppModel? getData() {
    var data = sharedPreferences?.getString(key);
    if (data != null) {
      return StartAppModel.fromJson(data);
    }

    // var data = box.read(key);
    // if (data != null) {
    //   return StartAppModel.fromJson(data);
    // }

    return null;
  }

  @override
  void clearData() {
    sharedPreferences?.remove(key);
    // box.remove(key);
  }
}
