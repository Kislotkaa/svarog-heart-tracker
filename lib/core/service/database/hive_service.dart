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
  late List<LazyBox> listBox = [];

  Future<HiveService> init() async {
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
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return this;
  }

  Future<List<E>> query<E>(LazyBox<E> box, {bool Function(E element)? where}) async {
    try {
      final keys = box.keys.toList().reversed;
      List<E> listModels = [];

      for (var key in keys) {
        final model = await box.get(key);
        if (model != null) {
          listModels.add(model);
        }
      }

      if (where != null && listModels.isNotEmpty) {
        List<E> filter = [];
        for (var element in listModels) {
          if (where(element)) filter.add(element);
        }
        listModels = filter;
      }

      return listModels;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
      return [];
    }
  }

  Future<void> delete<E>(LazyBox<E> box, {required bool Function(E element) where}) async {
    try {
      final keys = box.keys.toList().reversed;

      for (var key in keys) {
        final model = await box.get(key);
        if (model != null && where(model)) await box.delete(key);
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> update<E>(
    LazyBox<E> box, {
    required String id,
    required E model,
    required bool Function(E element) where,
  }) async {
    try {
      final keys = box.keys.toList().reversed;

      for (var key in keys) {
        final element = await box.get(key);
        if (element != null && where(element)) {
          await box.put(id, model);
        }
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> insert<E>(
    LazyBox<E> box, {
    required String id,
    required E model,
  }) async {
    try {
      await box.put(id, model);
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> clearDataBase<E>(
    LazyBox<E> box,
  ) async {
    try {
      await box.clear();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<bool> dataBaseIsEmpty() async {
    try {
      var isEmpty = true;
      for (var box in listBox) {
        if (box.keys.toList().isNotEmpty) {
          return false;
        }
      }
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
    Hive.registerAdapter(UserSettingsModelAdapter());
  }

  Future<void> _registreBox() async {
    List<LazyBox> listLazyBox = [];
    listLazyBox.add(await Hive.openLazyBox<UserModel>(DB_USERS_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserHistoryModel>(DB_USER_HISTORY_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserDetailModel>(DB_USER_DETAIL_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserSettingsModel>(DB_USER_SETTINGS_KEY));
    listBox = listLazyBox;
  }
}

enum HiveConflictAlgorithm {
  abort,
  ignore,
  replace,
}

enum HiveOrderBy {
  /// В обратном порядке
  ASC,

  /// По порядку
  DESC,
}
