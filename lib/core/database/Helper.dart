import 'dart:async';

import 'package:green_plant/helper/constance.dart';
import 'package:green_plant/models/notification_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "UserData.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableUser ( 
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnName TEXT NOT NULL,
          $columnImage TEXT NOT NULL,
          $columnBody TEXT NOT NULL)
          ''');
      },
    );
  }

  Future<NotificationModel> insert(NotificationModel user) async {
    var dbClient = await database;
    user.id = await dbClient.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<NotificationModel>> getAllUsers() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(
      tableUser,
    );
    List<NotificationModel> list = maps.isNotEmpty
        ? maps.map((user) => NotificationModel.fromMap(user)).toList()
        : [];

    return list;
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await database;
    return await dbClient
        .delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }
}
