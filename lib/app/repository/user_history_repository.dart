import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/app/controllers/sqllite_controller.dart';
import 'package:uuid/uuid.dart';

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
    result.forEach((element) {
      returnData.add(UserHistoryModel.fromMap(element));
    });
    return returnData;
  }

  Future<UserHistoryModel?> getHistoryByPk(String id) async {
    final result = await _db.query(
      tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
    late UserHistoryModel? returnData = null;

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
