import 'dart:convert';
import 'package:aot_scout/helpers/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:aot_scout/models/question.dart';

class Quiz with ChangeNotifier {
  final bool _isOnline;
  static const dbName = 'Quiz';
  final uri =
      Uri.parse('https://aot-scout-default-rtdb.firebaseio.com/question.json');
  final database = DB.instance;
  Quiz(bool isOnline, [List<Question>? questions])
      : _isOnline = isOnline,
        _questions = questions ?? [];

  List<Question> _questions;
  int _score = 0;
  int _currentQuestion = 0;

  int get finalScore => _score;

  List<Question> get questions {
    return [..._questions];
  }

  int get currentQuestion {
    return _currentQuestion;
  }

  String get remark {
    if (finalScore >= _questions.length * 0.7) {
      return 'You are an AOT boss.';
    } else if (finalScore >= _questions.length * 0.5) {
      return 'Your AOT knowledge is not too bad.';
    } else {
      return 'You have to rewatch AOT.';
    }
  }

  bool get anymoreQuestion => _currentQuestion < _questions.length;

  int get questionNumber => _questions.length;

  void questionAnswered(bool correct) {
    if (correct) _score = _score + 1;
    _currentQuestion++;
    notifyListeners();
  }

  Quiz copyWith() {
    return Quiz(_isOnline, _questions);
  }

  Future<void> getQuestion() async {
    if (_isOnline) {
      http.Response response = await http.get(uri);
      Map<String, dynamic>? questions =
          jsonDecode(response.body) as Map<String, dynamic>?;
      if (questions == null) {
        _questions = [];
      } else {
        _questions = questions.entries
            .map((question) => Question.fromMapEntry(question))
            .toList();
      }
    } else {
      var questions = await database.getQuestions();

      if (questions.isEmpty) {
        _questions = [];
      } else {
        var tempQuestions = List<Map<String, Object?>>.from(questions);
        tempQuestions = tempQuestions.map((question) {
          return {
            Question.kId: question[Question.kId],
            Question.kQuestion: question[Question.kQuestion],
            Question.kAnswer: question[Question.kAnswer],
            Question.kOptions:
                jsonDecode(question[Question.kOptions] as String),
          };
        }).toList();
        _questions = tempQuestions
            .map((question) => Question.fromMap(question))
            .toList();
      }
      notifyListeners();
    }
  }

  Future<void> addQuestion(Map<String, Object?> question) async {
    try {
      Question addedQuestion;
      if (_isOnline) {
        var jsonQuestion = Question.toJson(question);
        var responseId = (await http.post(uri, body: jsonQuestion)).body;
        addedQuestion = Question.fromJson(responseId, question);
      } else {
        question[Question.kId] = await database.addQuestion(question);
        addedQuestion = Question.fromMap(question);
      }
      _questions.add(addedQuestion);
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> editQuestion(Map<String, Object?> question) async {
    try {
      if (_isOnline) {
        final uri = Uri.parse(
            'https://aot-scout-default-rtdatabase.firebaseio.com/question/${question[Question.kId]}.json');
        await http.patch(uri, body: Question.toJson(question));
      } else {
        await database.editQuestion(question);
      }
      var index = _questions.indexWhere(
          (tempQuestion) => question[Question.kId] == tempQuestion.id);
      _questions[index] = Question.fromMap(question);
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> deleteQuestion(Question question) async {
    try {
      if (_isOnline) {
        await http.delete(Uri.parse(
            'https://aot-scout-default-rtdatabase.firebaseio.com/question.json'));
      } else {
        await database.deleteQuestion(question);
      }
      _questions
          .removeWhere((removedQuestion) => question.id == removedQuestion.id);
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> deleteQuiz() async {
    try {
      if (_isOnline) {
        await http.delete(Uri.parse(
            'https://aot-scout-default-rtdatabase.firebaseio.com/question.json'));
      } else {
        await database.deleteQuiz();
      }
      _questions = [];
      notifyListeners();
      return;
    } catch (exception) {
      rethrow;
    }
  }
}
