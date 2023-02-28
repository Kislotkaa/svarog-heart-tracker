import 'package:get_storage/get_storage.dart';

abstract class AbstractDataSource {
  final box = GetStorage();
  String get key => '';

  Future<dynamic> setData(param) async {}
  dynamic getData() async {}
  void clearData() async {}
}
