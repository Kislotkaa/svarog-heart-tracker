import 'package:dartx/dartx.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/app/controllers/sqllite_controller.dart';

import '../models/user_model.dart';

class UserRepository {
  Database get _db => SqlLiteController.to.db;
  final String tableName = 'user';

  Future<List<UserModel>> getUsers() async {
    final result = await _db.query(
      tableName,
    );

    final List<UserModel> returnData = [];
    result.forEach((element) {
      returnData.add(UserModel.fromMap(element));
    });
    return returnData;
  }

  Future<UserModel?> getUserByPk(String id) async {
    final result = await _db.query(
      tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
    final List<UserModel> returnData = [];
    result.forEach((element) {
      returnData.add(UserModel.fromMap(element));
    });
    return returnData.firstOrNull;
  }

  Future<void> insertUser(
    String id,
    String personName,
    String deviceName,
  ) async {
    await _db.insert(
      tableName,
      conflictAlgorithm: ConflictAlgorithm.ignore,
      UserModel(
        id: id,
        personName: personName,
        deviceName: deviceName,
      ).toMap(),
    );
  }

  Future<void> updateUserByPk(UserModel user) async {
    await _db.update(
      tableName,
      conflictAlgorithm: ConflictAlgorithm.replace,
      user.toMap(),
      where: '"id" = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> removeUserByPk(String id) async {
    await _db.delete(
      tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
  }
}
