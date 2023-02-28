import 'package:get/get.dart';

import '../cache/language_cache_datasource.dart';

class LanguagesAppController extends GetxController {
  LanguagesAppController({required this.cache});

  final LanguageCacheDataSource cache;
  String? get currentLanguage => getCache();

  Future<void> setCache(String? value) async {
    if (value != null) return cache.setData(value);
  }

  String? getCache() {
    String? data = cache.getData();
    return data;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    if (getCache() == null) checkDevice();
  }

  void checkDevice() {
    switch (Get.deviceLocale?.toString()) {
      case 'en_EN':
        setCache('en_EN');
        break;
      default:
        setCache('ru_RU');
    }
  }
}
