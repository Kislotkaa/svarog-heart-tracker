import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/app/controllers/sqllite_controller.dart';

import '../models/user_history_model.dart';

class UserHistoryRepository {
  Database get _db => SqlLiteController.to.db;
  final String tableName = 'user_history';

  Future<List<UserHistoryModel?>> getHistoryUserByPk(String id) async {
    final result = await _db.query(
      tableName,
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

  Future<UserHistoryModel?> getHistoryByPk(String id) async {
    final result = await _db.query(
      tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
    late UserHistoryModel? returnData;

    if (result.isNotEmpty) {
      returnData = UserHistoryModel.fromMap(result.first);
    }

    return returnData;
  }

  Future<void> insertHistory(UserHistoryModel model) async {
    await _db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeHistoryByPk(String id) async {
    await _db.delete(
      tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
  }
}
