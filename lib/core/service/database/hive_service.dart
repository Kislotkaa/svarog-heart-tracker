// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Future<List<E>> query<E>(
    LazyBox<E> box, {
    bool Function(E element)? where,
    HivePagination? pagination,
  }) async {
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

      if (listModels is List<UserHistoryModel>) {
        final List<UserHistoryModel> listSorted = listModels.cast<UserHistoryModel>();
        listSorted.sort((a, b) {
          if (a.createAt == null || b.createAt == null) {
            return 0;
          } else {
            return b.createAt!.compareTo(a.createAt!);
          }
        });
      }

      if (pagination != null) {
        final currentPage = pagination.page;

        final firstElement = currentPage == 1 ? 0 : (currentPage - 1) * pagination.limit;
        final lastElement = currentPage * pagination.limit;
        final lenghtList = listModels.length;
        if (firstElement > lenghtList) {
          return [];
        }

        if (lenghtList >= lastElement) {
          return listModels.getRange(firstElement, lastElement).toList();
        } else {
          return listModels.getRange(firstElement, lenghtList).toList();
        }
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
  }

  Future<void> _registreBox() async {
    List<LazyBox> listLazyBox = [];
    listLazyBox.add(await Hive.openLazyBox<UserModel>(DB_USERS_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserHistoryModel>(DB_USER_HISTORY_KEY));
    listLazyBox.add(await Hive.openLazyBox<UserDetailModel>(DB_USER_DETAIL_KEY));
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

class HivePagination {
  /// Количество элементов в списке
  final int limit;

  /// Страница всегда > 1
  int page;

  bool isEnd;

  HivePagination({
    this.limit = 5,
    this.page = 1,
    this.isEnd = false,
  }) {
    if (page < 1) {
      page = 1;
    }
  }

  HivePagination copyWith({
    int? limit,
    int? page,
    bool? isEnd,
  }) {
    return HivePagination(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      isEnd: isEnd ?? this.isEnd,
    );
  }
}
