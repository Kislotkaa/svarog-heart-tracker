import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/utils/service/database_service/sqllite_service.dart';

abstract class UserHistoryDataSource {
  Future<List<UserHistoryModel>> getUserHistoryByPk(String id);
  Future<UserHistoryModel?> getHistoryByPk(String id);
  Future<void> insertHistory(UserHistoryModel params);
  Future<void> removeHistoryByPk(String id);
  Future<void> clearDatabase();
}

class UserHistoryDataSourceImpl extends UserHistoryDataSource {
  final SqlLiteService sqlLiteService;
  final String _tableName = 'user_history';
  Database get _db => sqlLiteService.db;

  UserHistoryDataSourceImpl({required this.sqlLiteService});

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
  Future<void> removeHistoryByPk(String id) async {
    await _db.delete(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> clearDatabase() async {
    await _db.rawDelete('DELETE FROM user');
    await _db.rawDelete('DELETE FROM user_history');
  }
}
