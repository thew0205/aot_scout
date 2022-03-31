import 'package:aot_scout/helpers/database.dart';
import 'package:aot_scout/models/todo.dart';
import 'package:flutter/cupertino.dart';

class Todolist with ChangeNotifier {
  Todolist({
    List<Todo>? todos,
  }) : _todos = todos ?? [];
  static const dbName = 'Todos';
  final database = DB.instance;
  List<Todo> _todos;

  List<Todo> get todos {
    return [..._todos];
  }

  List<Todo> get completedTodos {
    return _todos.where((todo) => todo.completed).toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  List<Todo> get uncompletedTodos {
    return _todos.where((todo) => !todo.completed).toList()
      ..sort((todo, otherTodo) => todo.compareTime(otherTodo));
  }

  List<Todo> get todayTodos {
    final day = DateTime.now();
    return _todos.where((todo) => todo.toBeCompleted.day == day.day).toList();
  }

  List<Todo> get completedTodayTodos {
    final day = DateTime.now();
    return _todos
        .where((todo) => todo.toBeCompleted.day == day.day && todo.completed)
        .toList();
  }

  List<Todo> get uncompletedTodayTodos {
    final day = DateTime.now();
    return _todos
        .where((todo) => todo.toBeCompleted.day == day.day && !todo.completed)
        .toList();
  }

  List<Todo> get thisWeekTodos {
    final today = DateTime.now();
    final todayDay = today.weekday;
    return _todos.where((todo) {
      final day = todo.toBeCompleted.difference(today).inDays;
      return day > (todayDay - DateTime.daysPerWeek) || day < (1 - todayDay);
    }).toList();
  }

  List<Todo> get completedThisWeekTodos {
    final today = DateTime.now();
    final todayDay = today.weekday;
    return _todos.where((todo) {
      final day = todo.toBeCompleted.difference(today).inDays;
      return ((day > (todayDay - DateTime.daysPerWeek) ||
              day < (1 - todayDay)) &&
          todo.completed);
    }).toList();
  }

  List<Todo> get uncompletedThisWeekTodos {
    final today = DateTime.now();
    final todayDay = today.weekday;
    return _todos.where((todo) {
      final day = todo.toBeCompleted.difference(today).inDays;
      return ((day > (todayDay - DateTime.daysPerWeek) ||
              day < (1 - todayDay)) &&
          !todo.completed);
    }).toList();
  }

  Future<void> getTodo() async {
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
          Todo.kDecription: todo[Todo.kDecription],
          Todo.kImportance: todo[Todo.kImportance],
          Todo.kCompleted: todo[Todo.kCompleted]
        };
      }).toList();
      _todos = temptodos.map((todo) => Todo.fromMap(todo)).toList();
      print(_todos);
      print(76868976);
      _todos.sort((todo, otherTodo) => todo.compareTime(otherTodo));
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

  bool completed = false;

  Future<void> chnageTodoCompletion(Todo todo) async {
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
      print(_todos);
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
