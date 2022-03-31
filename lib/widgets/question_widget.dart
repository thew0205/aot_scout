import 'package:aot_scout/models/question.dart';
import 'package:aot_scout/models/quiz.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key? key,
    required Question question,
  })  : _question = question,
        super(key: key);

  final Question _question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                widget._question.question,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4!,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var option in widget._question.options)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: TextButton(
                    child: Text(option),
                    style: Theme.of(context).textButtonTheme.style,
                    onPressed: () {
                      Provider.of<Quiz>(context, listen: false)
                          .questionAnswered(option ==
                              widget._question
                                  .options[widget._question.answer - 1]);
                    },
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
