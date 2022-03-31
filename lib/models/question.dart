import 'package:flutter/foundation.dart';
import 'dart:convert';

class Question with ChangeNotifier {
  static const kId = 'id';
  static const kQuestion = 'question';
  static const kOptions = 'options';
  static const kAnswer = 'answer';

  final Object _id;
  final String _question;
  final List<String> _options;
  final int _answer;

  Question({
    required Object id,
    required String question,
    required List<String> options,
    required int answer,
  })  : _id = id,
        _options = options,
        _question = question,
        _answer = answer;

  Question makeFrom({
    String? question,
    List<String>? options,
    int? answer,
  }) {
    return Question(
      id: _id,
      question: question ?? _question,
      options: options ?? _options,
      answer: answer ?? _answer,
    );
  }

  String get question => _question;
  List<String> get options => _options;
  int get answer => _answer;
  int get optionsNumber => _options.length;
  Object get id => _id;

  static String toJson(Map<String, Object?> question) {
    return jsonEncode({
      kQuestion: question[kQuestion],
      kAnswer: question[kAnswer],
      kOptions: question[kOptions],
    });
  }

  //{"-Mvj71nbGtTRii-BeIP6":{"quetion":"why is David a fool sexpornnudecum "}}
  static Question fromJson(String response, Map<String, Object?> question) {
    var mapResponse = jsonDecode(response);

    return Question(
      id: mapResponse['name'] as String,
      answer: question[kAnswer] as int,
      options: question[kOptions] as List<String>,
      question: question[kQuestion] as String,
    );
  }

  static Question fromMap(Map<String, dynamic> inputMap) {
    return Question(
      id: inputMap[kId],
      question: inputMap[kQuestion] as String,
      options: ((inputMap[kOptions] as List<dynamic>)
          .map((option) => option as String)
          .toList()),
      answer: inputMap[kAnswer] as int,
    );
  }

  static Question fromMapEntry(MapEntry<String, dynamic> inputMap) {
    return Question(
      id: inputMap.key,
      question: inputMap.value[kQuestion] as String,
      options: ((inputMap.value[kOptions] as List<dynamic>)
          .map((option) => option as String)
          .toList()),
      answer: inputMap.value[kAnswer] as int,
    );
  }

  // @override
  // String toString() {
  //   return toJson();
  // }
}
