import 'package:hive/hive.dart';
import 'package:svarog_heart_tracker/core/constant/db_keys.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';

abstract class UserDetailDataSource {
  Future<UserDetailModel?> getUserDetailByPk(String id);
  Future<UserDetailModel> updateUserDetailByPk(UserDetailModel params);
  Future<UserDetailModel> insertUserDetailByPk(UserDetailModel params);
  Future<void> removeDetailByPk(String id);
  Future<void> clearDatabase();
}

class UserDetailDataSourceHiveImpl extends UserDetailDataSource {
  final HiveService hiveService;
  final box = Hive.lazyBox<UserDetailModel>(DB_USER_DETAIL_KEY);

  UserDetailDataSourceHiveImpl({required this.hiveService});

  @override
  Future<UserDetailModel?> getUserDetailByPk(String id) async {
    final result = await hiveService.query(box, where: (element) => element.id == id);

    return result.firstOrNull;
  }

  @override
  Future<UserDetailModel> updateUserDetailByPk(UserDetailModel params) async {
    await hiveService.update(
      box,
      where: (element) => element.id == params.id,
      id: params.id,
      model: params,
    );
    return params;
  }

  @override
  Future<UserDetailModel> insertUserDetailByPk(UserDetailModel params) async {
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
  Future<void> removeDetailByPk(String id) async {
    await hiveService.delete(box, where: (element) => element.id == id);
  }
}
