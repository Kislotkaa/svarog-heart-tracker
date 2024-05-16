import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/database/sqllite_service.dart';
import 'package:uuid/uuid.dart';

abstract class UserSettingsDataSource {
  Future<UserSettingsModel> getUserSettingsByPk(String id);
  Future<UserSettingsModel> updateUserSettingsByPk(UserSettingsModel params);
  Future<void> clearDatabase();
}

class UserHistoryDataSourceImpl extends UserSettingsDataSource {
  final SqlLiteService sqlLiteService;
  final String _tableName = 'user_settings';
  Database get _db => sqlLiteService.db;

  UserHistoryDataSourceImpl({required this.sqlLiteService});

  @override
  Future<UserSettingsModel> getUserSettingsByPk(String id) async {
    final result = await _db.query(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return UserSettingsModel.fromMap(result.first);
    }

    return UserSettingsModel(id: const Uuid().v4());
  }

  @override
  Future<UserSettingsModel> updateUserSettingsByPk(UserSettingsModel params) async {
    await _db.update(
      _tableName,
      conflictAlgorithm: ConflictAlgorithm.replace,
      params.toMap(),
      where: '"id" = ?',
      whereArgs: [params.id],
    );
    return params;
  }

  @override
  Future<void> clearDatabase() async {
    await _db.rawDelete('DELETE FROM user_history');
  }
}
