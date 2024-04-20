import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/utils/service/database_service.dart/sqllite_service.dart';

abstract class UserHistoryDataSource {
  Future<List<UserHistoryModel>> getUserHistoryByPk(String id);
  Future<UserHistoryModel?> getHistoryByPk(String id);
  Future<void> insertHistory(UserHistoryModel params);
  Future<void> removeHistoryByPk(String id);
}

class UserHistoryDataSourceImpl extends UserHistoryDataSource {
  final SqlLiteService sqlLiteService;
  final String _tableName = 'user_history';
  get _db => sqlLiteService.db;

  UserHistoryDataSourceImpl({required this.sqlLiteService});

  @override
  Future<UserHistoryModel?> getHistoryByPk(String id) async {
    final result = await _db.query(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
    late UserHistoryModel? returnData;

    if (result.isNotEmpty) {
      returnData = UserHistoryModel.fromMap(result.first);
    }

    return returnData;
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
}
