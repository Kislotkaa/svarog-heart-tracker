import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:svarog_heart_tracker/app/helper/error_handler.dart';
import 'package:uuid/uuid.dart';

class SqlLiteController extends DisposableInterface {
  static SqlLiteController get to => Get.find<SqlLiteController>();

  late Database db;
  final int _version = 1;

  final RxBool isEmpty = true.obs;

  Future open() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'heart_tracker_sqllite.db');
    // await deleteDatabase(path); // Использовать если хотите сбросить базу
    db = await openDatabase(
      path,
      version: _version,
      onCreate: (db, v1) async => await _dbInit(db),
      onUpgrade: (db, v1, v2) async => await _dbReInit(db),
    );
  }

  Future<void> init() async {
    try {
      await open();
      await dataBaseIsEmpty();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> _dbInit(Database db) async {
    final uuid = Uuid();
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
  	createAt DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_fk FOREIGN KEY (userId) REFERENCES user (id)
    );''');
  }

  Future<void> _dbReInit(Database db) async {
    final uuid = Uuid();
    await _dbDrop(db);
    await _dbInit(db);
  }

  Future<void> _dbDrop(Database db) async {
    try {
      final uuid = Uuid();

      await db.execute('''DROP TABLE IF EXISTS user;''');
      await db.execute('''DROP TABLE IF EXISTS user_history;''');
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> clearDataBase() async {
    try {
      await db.rawDelete('DELETE FROM user');
      await db.rawDelete('DELETE FROM user_history');
      await dataBaseIsEmpty();
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<bool> dataBaseIsEmpty() async {
    try {
      var isEmptyTables = [];
      isEmptyTables.add((await db.rawQuery('SELECT * FROM user')).isEmpty);
      isEmptyTables
          .add((await db.rawQuery('SELECT * FROM user_history')).isEmpty);
      bool value = !isEmptyTables.contains(false);
      isEmpty.value = value;
      return value;
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
    return true;
  }
}
