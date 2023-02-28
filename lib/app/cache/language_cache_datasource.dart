import 'abstarct_data_source.dart';

class LanguageCacheDataSource extends AbstractDataSource {
  @override
  String get key => 'language';

  @override
  Future<void> setData(param) async {
    return await box.write(key, param);
  }

  @override
  String? getData() {
    String? data = box.read(key);
    return data;
  }

  @override
  void clearData() {
    box.remove(key);
  }
}
