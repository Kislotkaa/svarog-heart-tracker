import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/utils/service/database_service/sqllite_service.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel?> getUserByPk(String id);
  Future<void> insertUser(UserParams params);
  Future<UserModel?> updateUserByPk(UserParams params);
  Future<void> removeUserByPk(String id);
}

class UserDataSourceImpl extends UserDataSource {
  final SqlLiteService sqlLiteService;
  final String _tableName = 'user';
  get _db => sqlLiteService.db;

  UserDataSourceImpl({required this.sqlLiteService});

  @override
  Future<List<UserModel>> getUsers() async {
    final result = await _db.query(
      _tableName,
    );

    final List<UserModel> returnData = [];
    result.forEach((element) {
      returnData.add(UserModel.fromMap(element));
    });
    return returnData;
  }

  @override
  Future<UserModel?> getUserByPk(String id) async {
    final result = await _db.query(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
    final List<UserModel> returnData = [];
    result.forEach((element) {
      returnData.add(UserModel.fromMap(element));
    });
    return returnData.firstOrNull;
  }

  @override
  Future<void> insertUser(UserParams params) async {
    final userModel = UserModel(
      id: params.id,
      personName: params.personName,
      deviceName: params.deviceName,
    );
    await _db.insert(
      _tableName,
      conflictAlgorithm: ConflictAlgorithm.replace,
      userModel.toMap(),
    );
  }

  @override
  Future<void> removeUserByPk(String id) async {
    await _db.delete(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<UserModel?> updateUserByPk(UserParams params) async {
    final userModel = UserModel(
      id: params.id,
      personName: params.personName,
      deviceName: params.deviceName,
    );
    await _db.update(
      _tableName,
      conflictAlgorithm: ConflictAlgorithm.replace,
      userModel.toMap(),
      where: '"id" = ?',
      whereArgs: [params.id],
    );
    return userModel;
  }
}
