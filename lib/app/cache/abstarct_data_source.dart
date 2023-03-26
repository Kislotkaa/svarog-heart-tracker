import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractDataSource extends GetxController {
  final box = GetStorage();
  late SharedPreferences? sharedPreferences;

  String get key => '';

  Future<dynamic> setData(param) async {}
  dynamic getData() async {}
  void clearData() async {}

  @override
  Future<void> onInit() async {
    Get.printInfo(info: 'init AbstractDataSource');
    sharedPreferences = await SharedPreferences.getInstance();
    super.onInit();
  }
}
