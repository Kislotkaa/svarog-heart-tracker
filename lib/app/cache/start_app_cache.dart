import '../models/start_app_model.dart';
import 'abstarct_data_source.dart';

class StartAppCache extends AbstractDataSource {
  @override
  String get key => 'first_start_app';

  @override
  Future<void> setData(param) async {
    return await box.write(key, param);
  }

  @override
  StartAppModel? getData() {
    var data = box.read(key);
    if (data != null) {
      return StartAppModel.fromJson(data);
    }
    return null;
  }

  @override
  void clearData() {
    box.remove(key);
  }
}
