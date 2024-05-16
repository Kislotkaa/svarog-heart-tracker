import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/constant/db_keys.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';

class HiveService {
  late bool isEmpty = true;

  Future<void> init() async {
    try {
      late String tempDir = '';
      if (Platform.isIOS) {
        tempDir = (await getTemporaryDirectory()).path;
      } else if (Platform.isAndroid) {
        tempDir = await getDatabasesPath();
      }
      String path = '$tempDir/heart_tracker_hive';

      Hive.init(path);
      _registreAdapter();
      await _registreBox();

      log(' Hive Initial path: $path');

      test();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> test() async {
    final box = Hive.lazyBox<UserModel>(DB_USERS_KEY);
    await box.clear();
    await box.add(
      UserModel(
        id: '1',
        personName: 'personName',
        deviceName: 'deviceName',
      ),
    );
    await box.add(
      UserModel(
        id: '2',
        personName: 'personName',
        deviceName: 'deviceName',
      ),
    );
    await box.add(
      UserModel(
        id: '123',
        personName: 'personName',
        deviceName: 'deviceName',
      ),
    );

    var keys = box.keys.toList().reversed;

    for (var key in keys) {
      final user = await box.get(key);
      print('key:$key - user:${user}');
    }
  }

  Future<void> clearDataBase() async {
    try {
      // await db.rawDelete('DELETE FROM user');
      // await db.rawDelete('DELETE FROM user_history');
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<bool> dataBaseIsEmpty() async {
    try {
      var isEmptyTables = [];
      // isEmptyTables.add((await db.rawQuery('SELECT * FROM user')).isEmpty);
      // isEmptyTables.add((await db.rawQuery('SELECT * FROM user_history')).isEmpty);
      isEmpty = isEmptyTables.contains(true);
      return isEmpty;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return true;
  }

  void _registreAdapter() {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserHistoryModelAdapter());
    Hive.registerAdapter(UserDetailModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
  }

  Future<void> _registreBox() async {
    List<LazyBox> listLazyBox = [];
    listLazyBox.add(await Hive.openLazyBox<UserModel>(DB_USERS_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserHistoryModel>(DB_USER_HISTORY_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserDetailModel>(DB_USER_DETAIL_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserSettingsModel>(DB_USER_DETAIL_KEY));
  }
}
