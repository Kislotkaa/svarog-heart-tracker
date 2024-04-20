import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';

class SqlLiteService {
  late Database db;
  final int _version = 4;

  late bool isEmpty = true;

  Future open() async {
    try {
      late String tempDir = '';
      if (Platform.isIOS) {
        tempDir = (await getTemporaryDirectory()).path;
      } else if (Platform.isAndroid) {
        tempDir = await getDatabasesPath();
      }

      String path = '$tempDir/heart_tracker_sqllite.db';
      log(' DB Initial path: $path');

      db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, v1) async => await _dbInit(db),
        onUpgrade: (db, v1, v2) async => await _dbAlert(db),
      );
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> init() async {
    try {
      await open();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _dbInit(Database db) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS user (
    id TEXT PRIMARY KEY,
    personName TEXT,
    deviceName TEXT,
    isAutoConnect INTEGER
    );''');

    await db.execute('''CREATE TABLE IF NOT EXISTS user_history (
    id TEXT PRIMARY KEY,
    userId TEXT,
  	yHeart TEXT,
    avgHeart INTEGER,
    maxHeart INTEGER,
    minHeart INTEGER,
    redTimeHeart INTEGER,
    orangeTimeHeart INTEGER,
    greenTimeHeart INTEGER,
  	createAt TIMESTAMP,
  	finishedAt TIMESTAMP,
    CONSTRAINT user_fk FOREIGN KEY (userId) REFERENCES user (id)
    );''');
  }

  Future<void> _dbAlert(Database db) async {
    try {
      db.execute("ALTER TABLE user_history ADD COLUMN finishedAt TIMESTAMP;");
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> clearDataBase() async {
    try {
      await db.rawDelete('DELETE FROM user');
      await db.rawDelete('DELETE FROM user_history');
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<bool> dataBaseIsEmpty() async {
    try {
      var isEmptyTables = [];
      isEmptyTables.add((await db.rawQuery('SELECT * FROM user')).isEmpty);
      isEmptyTables.add((await db.rawQuery('SELECT * FROM user_history')).isEmpty);
      isEmpty = isEmptyTables.contains(true);
      return isEmpty;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return true;
  }
}
