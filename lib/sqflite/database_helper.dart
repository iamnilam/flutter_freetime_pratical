import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_pratical_project/sqflite/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String noteTable = 'note_table';
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable('
        '$colID INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT,'
        '$colDescription TEXT,'
        '$colPriority INTEGER, '
        '$colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNotMapList() async {
    Database db = await this.database;
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $noteTable where $colID = $id');
    return result;
  }

  Future<int?> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNotMapList();

    int count = noteMapList.length;
    List<Note> noteList = [];
    for (var i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
