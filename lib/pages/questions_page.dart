import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aot_scout/models/quiz.dart';
import 'package:aot_scout/pages/answer_page.dart';
import 'package:aot_scout/widgets/question_widget.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({Key? key, required Quiz quiz})
      : _quiz = quiz,
        super(key: key);
  final Quiz _quiz;

  static String page = '/QuizPage';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _quiz,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'AOT Quiz',
            ),
          ),
        ),
        body: Consumer<Quiz>(
          builder: (context, quiz, child) => quiz.anymoreQuestion
              ? QuestionWidget(question: quiz.questions[quiz.currentQuestion])
              : AnswerPage(quiz: quiz),
        ),
      ),
    );
  }
}
