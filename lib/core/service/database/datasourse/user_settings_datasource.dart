import 'package:hive/hive.dart';
import 'package:svarog_heart_tracker/core/constant/db_keys.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';

abstract class UserSettingsDataSource {
  Future<UserSettingsModel?> getUserSettingsByPk(String id);
  Future<UserSettingsModel> updateUserSettingsByPk(UserSettingsModel params);
  Future<UserSettingsModel> insertUserSettingsByPk(UserSettingsModel params);
  Future<void> removeSettingsByPk(String id);

  Future<void> clearDatabase();
}

class UserSettingsDataSourceHiveImpl extends UserSettingsDataSource {
  final HiveService hiveService;
  final box = Hive.lazyBox<UserSettingsModel>(DB_USER_SETTINGS_KEY);

  UserSettingsDataSourceHiveImpl({required this.hiveService});

  @override
  Future<UserSettingsModel?> getUserSettingsByPk(String id) async {
    final result = await hiveService.query(box, where: (element) => element.id == id);

    return result.firstOrNull;
  }

  @override
  Future<UserSettingsModel> updateUserSettingsByPk(UserSettingsModel params) async {
    await hiveService.update(
      box,
      where: (element) => element.id == params.id,
      id: params.id,
      model: params,
    );
    return params;
  }

  @override
  Future<UserSettingsModel> insertUserSettingsByPk(UserSettingsModel params) async {
    await hiveService.insert(
      box,
      id: params.id,
      model: params,
    );
    return params;
  }

  @override
  Future<void> clearDatabase() async {
    await hiveService.clearDataBase(box);
  }

  @override
  Future<void> removeSettingsByPk(String id) async {
    await hiveService.delete(box, where: (element) => element.id == id);
  }
}
