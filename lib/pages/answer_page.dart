import 'package:aot_scout/models/quiz.dart';
import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          heightFactor: 2,
          child: Text(
            'You had a final score of ${quiz.finalScore} out ${quiz.questionNumber}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                quiz.remark,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              Text(
                'You had ${(quiz.finalScore / quiz.questionNumber * 100).toStringAsFixed(1)}% percentage.',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
