import 'dart:convert';

import 'package:aot_scout/models/question.dart';
import 'package:aot_scout/models/quiz.dart';
import 'package:aot_scout/models/todo.dart';
import 'package:aot_scout/models/todolist.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DB {
  static final DB instance = DB._();

  DB._();

  factory DB() => instance;

  sql.Database? _database;

  Future<sql.Database> get database async {
    if (_database != null) return _database!;
    _database = await getDataBase();
    return _database!;
  }

  Future<sql.Database> getDataBase() async {
    var dbPath = path.join(await sql.getDatabasesPath(), 'aot.db');

    // await sql.deleteDatabase(dbPath);

    return await sql.openDatabase(
      dbPath,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''CREATE TABLE ${Quiz.dbName}(
          ${Question.kId} INTEGER PRIMARY KEY, 
          ${Question.kQuestion} TEXT NOT NULL,
          ${Question.kAnswer} INTEGER NOT NULL,
          ${Question.kOptions} TEXT NOT NULL
        )''');
        await database.execute('''CREATE TABLE ${Todolist.dbName}(
          ${Todo.kId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${Todo.kName} TEXT NOT NULL,
          ${Todo.kDecription} TEXT NOT NULL,
          ${Todo.kToBeCompleted} TEXT NOT NULL,
          ${Todo.kImportance} INTEGER NOT NULL,
          ${Todo.kCompleted} BOOLEAN NOT NULL
        )''');
      },
    );
  }

  Future<List<Map<String, Object?>>> getQuestions() async {
    return (await database).rawQuery('SELECT * FROM ${Quiz.dbName}');
  }

  Future<List<Map<String, Object?>>> getTodos() async {
    return (await database).rawQuery('SELECT * FROM ${Todolist.dbName}');
  }

  Future<int> addQuestion(Map<String, Object?> question) async {
    return (await database).rawInsert(
      ''' INSERT INTO ${Quiz.dbName}(${Question.kQuestion}, ${Question.kAnswer} , ${Question.kOptions}) 
      VALUES (?, ?, ?)''',
      [
        question[Question.kQuestion],
        question[Question.kAnswer],
        jsonEncode(question[Question.kOptions])
      ],
    );
  }

  Future<int> addTodo(Map<String, Object?> todo) async {
    return (await database).rawInsert(
      ''' INSERT INTO  ${Todolist.dbName}(${Todo.kName}, ${Todo.kDecription} , ${Todo.kToBeCompleted},
      ${Todo.kImportance},${Todo.kCompleted})
      VALUES (?, ?, ?, ?, ?)''',
      [
        todo[Todo.kName],
        todo[Todo.kDecription],
        todo[Todo.kToBeCompleted],
        todo[Todo.kImportance],
        todo[Todo.kCompleted]
      ],
    );
  }

  Future<int> editQuestion(Map<String, Object?> question) async {
    return (await database).rawUpdate(
      '''UPDATE ${Quiz.dbName} SET 
          ${Question.kQuestion} = ?, ${Question.kAnswer} = ?, ${Question.kOptions} = ?
          WHERE ${Question.kId} = ${question[Question.kId]}''',
      [
        question[Question.kQuestion],
        question[Question.kAnswer],
        jsonEncode(question[Question.kOptions])
      ],
    );
  }

  Future<int> editTodo(Map<String, Object?> todo) async {
    return (await database).rawUpdate(
      '''UPDATE  ${Todolist.dbName} SET ${Todo.kName} = ?, ${Todo.kDecription} = ?,
      ${Todo.kToBeCompleted} = ?,${Todo.kImportance} = ?,${Todo.kCompleted} = ?
      WHERE ${Todo.kId}= ${todo[Todo.kId]}''',
      [
        todo[Todo.kName],
        todo[Todo.kDecription],
        todo[Todo.kToBeCompleted],
        todo[Todo.kImportance],
        todo[Todo.kCompleted]
      ],
    );
  }

  Future<int> deleteQuestion(Question question) async {
    return (await database)
        .rawDelete('DELETE FROM ${Quiz.dbName} WHERE id = ?', [
      {question.id}
    ]);
  }

  Future<int> deleteTodo(Todo todo) async {
    return (await database)
        .rawDelete('DELETE FROM ${Todolist.dbName} WHERE id = ?', [
      {todo.id}
    ]);
  }

  Future<void> deleteQuiz() async {
    (await database).rawDelete(
        'DELETE FROM ${Quiz.dbName} WHERE ${Question.kId} is NOT NULL');
  }

  Future<void> deleteTodos() async {
    (await database).rawDelete(
        'DELETE FROM ${Todolist.dbName} WHERE ${Todo.kId} is NOT NULL');
  }
}
