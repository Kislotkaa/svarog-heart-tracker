import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/constant/db_keys.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/database/sqllite_service.dart';

abstract class UserHistoryDataSource {
  Future<List<UserHistoryModel>> getUserHistoryByPk(String id);
  Future<UserHistoryModel?> getHistoryByPk(String id);
  Future<void> insertHistory(UserHistoryModel params);
  Future<void> updateHistoryByPk(UserHistoryModel params);
  Future<void> removeHistoryByPk(String id);
  Future<void> clearDatabase();
}

class UserHistoryDataSourceSqlImpl extends UserHistoryDataSource {
  final SqlLiteService sqlLiteService;
  final String _tableName = 'user_history';
  Database get _db => sqlLiteService.db;

  UserHistoryDataSourceSqlImpl({required this.sqlLiteService});

  @override
  Future<UserHistoryModel?> getHistoryByPk(String id) async {
    final result = await _db.query(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return UserHistoryModel.fromMap(result.first);
    }

    return null;
  }

  @override
  Future<List<UserHistoryModel>> getUserHistoryByPk(String id) async {
    final result = await _db.query(
      _tableName,
      where: '"userId" = ?',
      whereArgs: [id],
      orderBy: 'createAt DESC',
    );
    final List<UserHistoryModel> returnData = [];
    for (var element in result) {
      returnData.add(UserHistoryModel.fromMap(element));
    }
    return returnData;
  }

  @override
  Future<void> insertHistory(UserHistoryModel params) async {
    await _db.insert(
      _tableName,
      params.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateHistoryByPk(UserHistoryModel params) async {}

  @override
  Future<void> removeHistoryByPk(String id) async {
    await _db.delete(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> clearDatabase() async {
    await _db.rawDelete('DELETE FROM $_tableName');
  }
}

class UserHistoryDataSourceHiveImpl extends UserHistoryDataSource {
  final HiveService hiveService;
  final box = Hive.lazyBox<UserHistoryModel>(DB_USER_HISTORY_KEY);

  UserHistoryDataSourceHiveImpl({required this.hiveService});

  @override
  Future<UserHistoryModel?> getHistoryByPk(String id) async {
    final result = await hiveService.query(box, where: (element) => element.id == id);

    return result.firstOrNull;
  }

  @override
  Future<List<UserHistoryModel>> getUserHistoryByPk(String id) async {
    final result = await hiveService.query(
      box,
      where: (element) => element.userId == id,
      // orderBy: 'createAt DESC',
    );

    return result;
  }

  @override
  Future<void> insertHistory(UserHistoryModel params) async {
    await hiveService.insert(
      box,
      id: params.id,
      model: params,
    );
  }

  @override
  Future<void> updateHistoryByPk(UserHistoryModel params) async {
    await hiveService.update(
      box,
      id: params.id,
      model: params,
      where: (element) => element.id == params.id,
    );
  }

  @override
  Future<void> removeHistoryByPk(String id) async {
    await hiveService.delete(box, where: (element) => element.id == id);
  }

  @override
  Future<void> clearDatabase() async {
    await hiveService.clearDataBase(box);
  }
}
