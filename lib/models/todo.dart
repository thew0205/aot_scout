import 'dart:convert';

import 'package:flutter/foundation.dart';

enum Importance {
  veryImportant,
  important,
  leastImportant,
}

class Todo extends ChangeNotifier {
  static const kId = 'id';
  static const kName = 'name';
  static const kDecription = 'decription';
  static const kToBeCompleted = 'toBeCompleted';
  static const kCompleted = 'bool';
  static const kImportance = 'importance';

  static Importance importanceFromInt(int importance) {
    switch (importance) {
      case 0:
        return Importance.leastImportant;
      case 1:
        return Importance.important;
      case 2:
        return Importance.veryImportant;
      default:
        return Importance.important;
    }
  }

  static int importanceToInt(Importance importance) {
    switch (importance) {
      case Importance.leastImportant:
        return 0;
      case Importance.important:
        return 1;
      case Importance.veryImportant:
        return 2;
    }
  }

  String get importanceToString {
    switch (importance) {
      case Importance.leastImportant:
        return 'Least\nimportant';
      case Importance.important:
        return 'Important';
      case Importance.veryImportant:
        return 'Very\nimportant';
    }
  }

  final int id;
  final String name;
  final String description;
  final DateTime toBeCompleted;
  final Importance importance;
  bool _completed;

  bool get completed => _completed;

  void changeCompleted(bool completed) {
    _completed = completed;
    notifyListeners();
  }

  Todo(
      {required this.id,
      required this.name,
      required this.description,
      required this.toBeCompleted,
      Importance? importance,
      bool? completed})
      : importance = importance ?? Importance.important,
        _completed = completed ?? false;

  Todo copyWith(
      {int? id,
      String? name,
      String? description,
      DateTime? toBeCompleted,
      bool? completed,
      Importance? importance}) {
    return Todo(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        toBeCompleted: toBeCompleted ?? this.toBeCompleted,
        completed: completed ?? _completed,
        importance: importance ?? this.importance);
  }

  int compareTime(Todo otherTodo) {
    if (toBeCompleted.isAfter(otherTodo.toBeCompleted)) {
      return 1;
    }
    if (toBeCompleted.isBefore(otherTodo.toBeCompleted)) {
      return -1;
    } else {
      return 0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      kId: id,
      kName: name,
      kDecription: description,
      kToBeCompleted: toBeCompleted.toIso8601String(),
      kCompleted: _completed ? 1 : 0,
      kImportance: importanceToInt(importance),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map[kId],
      name: map[kName] ?? '',
      description: map[kDecription] ?? '',
      toBeCompleted: DateTime.parse(map[kToBeCompleted]),
      completed: map[kCompleted] == 1,
      importance: importanceFromInt(map[kImportance]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, name: $name, description: $description, toBeCompleted: $toBeCompleted, _completed: $_completed)';
  }
}
