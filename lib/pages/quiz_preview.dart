import 'package:aot_scout/models/prefrence.dart';
import 'package:aot_scout/models/question.dart';
import 'package:aot_scout/models/quiz.dart';
import 'package:aot_scout/pages/add_question_page.dart';
import 'package:aot_scout/pages/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionPreviewPage extends StatelessWidget {
  const QuestionPreviewPage({Key? key}) : super(key: key);

  static const page = '/QuestionPage';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Quiz>(
      create: (_) => Quiz(context.read<Preference>().onlineStoragePref),
      builder: (context, child) {
        return const QuizPreview();
      },
    );
  }
}

class QuizPreview extends StatefulWidget {
  const QuizPreview({
    Key? key,
  }) : super(key: key);

  @override
  State<QuizPreview> createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  Future _addQuestion(Quiz quiz, Question? editQuestion) async {
    Map<String, Object?>? question = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return QuestionForm(question: editQuestion);
        },
      ),
    );

    var isNewQuestion = question != null;
    if (isNewQuestion) {
      showDialog(
        context: context,
        builder: (_) {
          return FutureBuilder<void>(
            future: question['id'] == null
                ? quiz.addQuestion(question)
                : quiz.editQuestion(question),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                Navigator.of(context).pop();
                return const Center();
              } else {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Center(
                      child: AlertDialog(
                        title: const Text(
                          'Error',
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                            'Error was encountered while trying to upload data'),
                        actions: [
                          TextButton(
                            child: const Text('Back'),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      ),
                    );
                  },
                );
                return const Center();
              }
            },
          );
        },
      );
    }
  }

  void _startQuiz(Quiz quiz) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return QuestionsPage(quiz: quiz.copyWith());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<Quiz>();
    return FutureBuilder(
      future: quiz.getQuestion(),
      builder: (context, snapShot) {
        context.watch<Quiz>();
        Widget body;
        if (snapShot.connectionState == ConnectionState.waiting) {
          body = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapShot.connectionState == ConnectionState.done &&
              !snapShot.hasError) {
            body = quiz.questions.isEmpty
                ? Center(
                    child: Text(
                      'Add questions to be added',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: quiz.questionNumber,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(
                                quiz.questions[index].question,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              subtitle: Text(
                                  'No of options: ${quiz.questions[index].optionsNumber}'),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text('${index + 1}'),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      _addQuestion(quiz, quiz.questions[index]);
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_rounded,
                                      color: Theme.of(context).errorColor,
                                    ),
                                    onPressed: () {
                                      quiz.deleteQuestion(
                                          quiz.questions[index]);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
          } else {
            body = const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Quiz Preview'),
            actions: [
              if (quiz.questions.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: quiz.deleteQuiz,
                ),
              if (quiz.questions.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  onPressed: () {
                    _startQuiz(quiz);
                  },
                ),
            ],
          ),
          body: SafeArea(
            child: body,
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.add),
            onPressed: () {
              _addQuestion(quiz, null);
            },
            label: const Text('Add question'),
          ),
        );
      },
    );
  }
}
