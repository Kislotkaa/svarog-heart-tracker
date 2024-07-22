import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/constant/db_keys.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/database/sqllite_service.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:svarog_heart_tracker/locator.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel?> getUserByPk(String id);
  Future<UserModel> insertUser(UserParams params);
  Future<UserModel?> updateUserByPk(UserParams params);
  Future<void> removeUserByPk(String id);
  Future<void> clearDatabase();
}

class UserDataSourceSqlImpl extends UserDataSource {
  final SqlLiteService sqlLiteService;
  final String _tableName = 'user';
  Database get _db => sqlLiteService.db;

  UserDataSourceSqlImpl({
    required this.sqlLiteService,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    final result = await _db.query(
      _tableName,
    );

    List<UserModel> returnData = [];
    for (var element in result) {
      returnData.add(UserModel.fromMap(element));
    }
    return returnData;
  }

  @override
  Future<UserModel?> getUserByPk(String id) async {
    final result = await _db.query(
      _tableName,
      where: '"id" = ?',
      whereArgs: [id],
    );
    List<UserModel> returnData = [];
    for (var element in result) {
      returnData.add(UserModel.fromMap(element));
    }
    return returnData.firstOrNull;
  }

  @override
  Future<UserModel> insertUser(UserParams params) async {
    final userModel = UserModel(
      id: params.id,
      userDetailId: params.userDetailId,
      userSettingsId: params.userSettingsId,
      personName: params.personName,
      deviceName: params.deviceName,
      isAutoConnect: params.isAutoConnect,
    );
    await _db.insert(
      _tableName,
      conflictAlgorithm: ConflictAlgorithm.replace,
      userModel.toMap(),
    );
    return userModel;
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
      isAutoConnect: params.isAutoConnect,
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

  @override
  Future<void> clearDatabase() async {
    await _db.rawDelete('DELETE FROM $_tableName');
  }
}

class UserDataSourceHiveImpl extends UserDataSource {
  final HiveService hiveService;
  final box = Hive.lazyBox<UserModel>(DB_USERS_KEY);
  bool? isMigrateHive = sl<GlobalSettingsService>().appSettings.isMigratedHive;

  UserDataSourceHiveImpl({
    required this.hiveService,
    this.isMigrateHive,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    final result = await hiveService.query(box);
    return result;
  }

  @override
  Future<UserModel?> getUserByPk(String id) async {
    final result = await hiveService.query(box, where: (element) => element.id == id);
    return result.firstOrNull;
  }

  @override
  Future<UserModel> insertUser(UserParams params) async {
    final userModel = UserModel(
      id: params.id,
      userSettingsId: params.userSettingsId,
      userDetailId: params.userDetailId,
      personName: params.personName,
      deviceName: params.deviceName,
      isAutoConnect: params.isAutoConnect,
    );
    await hiveService.insert(box, id: userModel.id, model: userModel);
    return userModel;
  }

  @override
  Future<void> removeUserByPk(String id) async {
    await hiveService.delete(box, where: (element) => element.id == id);
  }

  @override
  Future<UserModel?> updateUserByPk(UserParams params) async {
    final userModel = UserModel(
      id: params.id,
      userSettingsId: params.userSettingsId,
      userDetailId: params.userDetailId,
      personName: params.personName,
      deviceName: params.deviceName,
      isAutoConnect: params.isAutoConnect,
    );
    await hiveService.update(
      box,
      model: userModel,
      id: userModel.id,
      where: (element) => element.id == userModel.id,
    );
    return userModel;
  }

  @override
  Future<void> clearDatabase() async {
    await hiveService.clearDataBase(box);
  }
}
