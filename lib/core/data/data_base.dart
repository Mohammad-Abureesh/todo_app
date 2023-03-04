// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

import '/core/constants/data_base_config.dart';

abstract class CreateDataBase {
  static late Database db;

  static Future<void> create() async {
    await open();
  }

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), DbConfig.dbName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE ${DbConfig.categoryT}(
      id  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      color INTEGER NOT NULL,
      icon INTEGER NOT NULL,
      name TEXT NOT NULL,
      createdAt TEXT NOT NULL);
      ''');

      await db.execute('''CREATE TABLE ${DbConfig.taskT}(
      id INTEGER PRIMARY KEY NOT NULL,
      categoryId INTEGER,
      status INTEGER NOT NULL,
      title TEXT NOT NULL,
      description TEXT,
      createdAt TEXT NOT NULL,
      dueDate TEXT); ''');
    });
  } //end open
}
