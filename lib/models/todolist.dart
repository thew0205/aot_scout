import 'package:aot_scout/helpers/database.dart';
import 'package:aot_scout/models/todo.dart';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/foundation.dart';

class Todolist with ChangeNotifier {
  Todolist({
    List<Todo>? todos,
  }) : _todos = todos ?? [];

  static const dbName = 'Todos';
  final database = DB.instance;
  List<Todo> _todos;
  List<String> labels = ["Personal", "School", "Work", "All"];

  List<Todo> get todos {
    return [..._todos];
  }

  List<Todo> _todayTodos = [];

  List<Todo> get todayTodos => _todayTodos;

  void setTodayTodos() {
    final day = DateTime.now();
    _todayTodos = _todos
        .where((todo) =>
            todo.toBeCompleted.day == day.day &&
            todo.toBeCompleted.month == day.month &&
            todo.toBeCompleted.year == day.year)
        .toList();
  }

  List<Todo> uncompletedTodayTodos() {
    return _todayTodos
        .where((todo) =>
            !todo.completed && (label == "All" ? true : todo.label == label))
        .toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  List<Todo> completedTodayTodos() {
    return _todayTodos
        .where((todo) =>
            todo.completed && (label == "All" ? true : todo.label == label))
        .toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  List<Todo> _otherTodos = [];

  void setOtherTodos() {
    final day = DateTime.now();
    _otherTodos = _todos.where((todo) {
      return todo.toBeCompleted.day != day.day ||
          todo.toBeCompleted.month != day.month ||
          todo.toBeCompleted.year != day.year;
    }).toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  List<Todo> get otherTodos => _otherTodos;

  List<Todo> uncompletedOtherTodos() {
    return _otherTodos
        .where((todo) =>
            !todo.completed && (label == "All" ? true : todo.label == label))
        .toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  List<Todo> completedOtherTodos() {
    return _otherTodos
        .where((todo) =>
            todo.completed && (label == "All" ? true : todo.label == label))
        .toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  Future<void> initializeTodos() async {
    var todos = await database.getTodos();

    if (todos.isEmpty) {
      _todos = [];
    } else {
      var temptodos = List<Map<String, Object?>>.from(todos);
      temptodos = temptodos.map((todo) {
        return {
          Todo.kId: todo[Todo.kId],
          Todo.kName: todo[Todo.kName],
          Todo.kToBeCompleted: todo[Todo.kToBeCompleted],
          Todo.kDescription: todo[Todo.kDescription],
          Todo.kImportance: todo[Todo.kImportance],
          Todo.kCompleted: todo[Todo.kCompleted],
          Todo.kLabel: todo[Todo.kLabel],
        };
      }).toList();
      _todos = temptodos.map((todo) => Todo.fromMap(todo)).toList();

      _todos.sort((todo, otherTodo) => todo.compareTime(otherTodo));
      setTodayTodos();
      setOtherTodos();
    }
    notifyListeners();
  }

  Future<void> addTodo(Map<String, Object?> todo) async {
    try {
      todo[Todo.kId] = await database.addTodo(todo);
      _todos.add(Todo.fromMap(todo));
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }

  bool _completed = false;
  bool get completed => _completed;
  void setCompleted() {
    _completed = !_completed;
    notifyListeners();
  }

  String _label = "Personal";
  String get label => _label;
  set label(String label) {
    _label = label;
    notifyListeners();
  }

  void addLabel(String label) {
    labels.add(label);
    this.label = label;
  }

  Future<void> changeTodoCompletion(Todo todo) async {
    todo.changeCompleted(!todo.completed);
    await Future.delayed(const Duration(milliseconds: 500));
    await editTodo(todo.toMap());
    return;
  }

  Future<void> editTodo(Map<String, Object?> todo) async {
    try {
      await database.editTodo(todo);
      var index =
          _todos.indexWhere((tempTodo) => todo[Todo.kId] == tempTodo.id);
      _todos[index] = Todo.fromMap(todo);
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await database.deleteTodo(todo);
      _todos.removeWhere((todo) => todo.id == todo.id);
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> deleteTodos() async {
    try {
      await database.deleteTodos();
      _todos = [];
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }
}
