import 'package:flutter/material.dart';

import 'package:aot_scout/models/question.dart';
import 'package:aot_scout/widgets/button_widget.dart';
import 'package:aot_scout/widgets/option_fieldform.dart';
import 'package:aot_scout/widgets/question_textfield.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({Question? question, Key? key})
      : _question = question,
        super(key: key);

  final Question? _question;

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  late final TextEditingController _questionFieldController;
  late final TextEditingController _optionFieldController;
  late final TextEditingController _answerFieldController;
  late final List<TextEditingController> _fieldcontroller;
  // Question? question;
  late Object? _id;
  late final bool _isQuestion;
  late String? _question;
  late List<String>? _options;
  late int? _answer;
  // late final int _optionNumber;
  String? _validateQuestion;
  String? _validateOptionNumber;
  String? _validateAnswer;

  late bool _isQuestionInputed;

  late final FocusNode _questionFocus;
  late final FocusNode _optionFocus;
  late final FocusNode _answerFocus;

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isQuestion = widget._question != null;
    _question = _isQuestion ? widget._question!.question : null;
    _id = _isQuestion ? widget._question!.id : null;

    _answer = _isQuestion ? widget._question!.answer : null;
    _validateQuestion = null;
    _validateOptionNumber = null;
    _validateAnswer = null;
    _isQuestionInputed = false;
    _questionFocus = FocusNode();
    _optionFocus = FocusNode();
    _answerFocus = FocusNode();
    _answerFieldController = TextEditingController()
      ..text = _isQuestion ? _answer!.toString() : '';
    _questionFieldController = TextEditingController()
      ..text = _isQuestion ? _question! : '';
    _optionFieldController = TextEditingController()
      ..text = _isQuestion ? widget._question!.optionsNumber.toString() : '';
  }

  @override
  void dispose() {
    super.dispose();
    _questionFieldController.dispose();
    _answerFieldController.dispose();
    _answerFocus.dispose();
    _optionFocus.dispose();
    _optionFieldController.dispose();
    _questionFocus.dispose();
  }

  void _onInptedQuestion(String value) {
    _validateQuestion = _questionValidation(_questionFieldController.text);
    if (_validateQuestion == null) {
      setState(() {
        FocusScope.of(context).requestFocus(_optionFocus);
      });
    } else {
      setState(() {
        FocusScope.of(context).requestFocus(_questionFocus);
      });
    }
  }

  void _onInputedOptionNumber(String value) {
    _validateOptionNumber =
        _optionNumberValidation(_optionFieldController.text);
    if (_validateOptionNumber == null) {
      setState(() {
        FocusScope.of(context).requestFocus(_answerFocus);
      });
    } else {
      setState(() {
        FocusScope.of(context).requestFocus(_optionFocus);
      });
    }
  }

  String? _questionValidation(String? text) {
    if (text == null) {
      return 'Enter a question';
    } else if (text.characters.length < 10) {
      return 'Enter a valid question';
    } else if (!text.contains(' ')) {
      return 'Enter a valid question with space ';
    } else {
      return null;
    }
  }

  String? _optionNumberValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter a number of options.';
    } else if (int.tryParse(value) == null) {
      return 'Please enter a valid number.';
    } else if (int.parse(value) < 2 || int.parse(value) > 5) {
      return 'Please enter a number greater than one and less than 6.';
    } else {
      return null;
    }
  }

  String? _answerValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter a answer.';
    }
    if (value.characters.length > 1) {
      return 'Just input one option';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number.';
    }
    if (int.parse(value) < 1 ||
        int.parse(value) > int.parse(_optionFieldController.text)) {
      return 'Please enter a number greater than zero and less than the number of options.';
    }
    return null;
  }

  void _onInputedAnswer(String value) {
    setState(() {
      _validateQuestion = _questionValidation(_questionFieldController.text);
      _validateOptionNumber =
          _optionNumberValidation(_optionFieldController.text);
      _validateAnswer = _answerValidation(value);
      if (_validateQuestion == null &&
          _validateOptionNumber == null &&
          _validateAnswer == null) {
        if (_isQuestion) {
          // question = question!.copyWith(
          // question: _questionFieldController.text,
          // answer: int.parse(_answerFieldController.text),
          // );

          // question = Question(
          //   question: _questionFieldController.text,
          //   options: question!.options,
          //   answer: int.parse(_answerFieldController.text),
          // );
        } else {
          // var _options = List.generate(
          //     int.parse(_optionFieldController.text), (index) => '');
          //question = Question(
          //   question: _questionFieldController.text,
          //   options: _options,
          //   answer: int.parse(_answerFieldController.text),
          // );
        }
        _isQuestionInputed = !_isQuestionInputed;
        _question = _questionFieldController.text;
        _answer = int.parse(_answerFieldController.text);
        _options = _isQuestion
            ? widget._question!.options
            : List.generate(
                int.parse(_optionFieldController.text), (index) => '');
        _fieldcontroller = _isQuestion
            ? List.generate(_options!.length,
                (index) => TextEditingController()..text = _options![index])
            : List.generate(
                _options!.length, (index) => TextEditingController());
      } else {
        FocusScope.of(context).requestFocus(_questionFocus);
      }
    });
  }

  String? _optionValidation(String? value) {
    if (value == null) {
      return 'Enter a option';
    } else if (value.isEmpty) {
      return 'Enter a valid option';
    } else {
      return null;
    }
  }

  void Function(String?) _onSavedGenerator(int i) {
    return (value) {
      _options![i] = value!;
    };
  }

  void _submitOptions() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      var question = {
        Question.kId: _id,
        Question.kQuestion: _question!,
        Question.kAnswer: _answer!,
        Question.kOptions: _options!,
      };
      Navigator.of(context).pop(question);
    }
  }

  void _back() {
    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: _back,
        ),
        title: const Text('Add a new question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  if (!_isQuestionInputed)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              QuestionTextField(
                                controller: _questionFieldController,
                                focus: _questionFocus,
                                onPressed: _onInptedQuestion,
                                errorText: _validateQuestion,
                                labelText: 'Enter the question to be asked',
                                textInputAction: TextInputAction.next,
                              ),
                              QuestionTextField(
                                enabled: !_isQuestion,
                                controller: _optionFieldController,
                                focus: _optionFocus,
                                onPressed: _onInputedOptionNumber,
                                errorText: _validateOptionNumber,
                                labelText:
                                    'Enter the number of options to the question',
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                              QuestionTextField(
                                controller: _answerFieldController,
                                focus: _answerFocus,
                                onPressed: _onInputedAnswer,
                                errorText: _validateAnswer,
                                labelText: 'Input answer(A,B,C...)',
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!_isQuestionInputed)
                    Button(
                      text: 'Submit question',
                      onPressed: () {
                        _onInputedAnswer(_answerFieldController.text);
                      },
                    ),
                  if (_isQuestionInputed)
                    Expanded(
                      child: Form(
                        key: _form,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var i = 0; i < _options!.length; i++)
                                MyFormField(
                                  controller: _fieldcontroller[i],
                                  labelText: 'Option $i',
                                  errorText: _validateQuestion,
                                  onSaved: _onSavedGenerator(i),
                                  validator: _optionValidation,
                                ),
                              if (_isQuestionInputed)
                                Button(
                                  text: 'Submit options',
                                  onPressed: _submitOptions,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              )
            : Row(
                children: [
                  if (!_isQuestionInputed)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              QuestionTextField(
                                controller: _questionFieldController,
                                focus: _questionFocus,
                                onPressed: _onInptedQuestion,
                                errorText: _validateQuestion,
                                labelText: 'Enter the question to be asked',
                                textInputAction: TextInputAction.next,
                              ),
                              QuestionTextField(
                                enabled: !_isQuestion,
                                controller: _optionFieldController,
                                focus: _optionFocus,
                                onPressed: _onInputedOptionNumber,
                                errorText: _validateOptionNumber,
                                labelText:
                                    'Enter the number of options to the question',
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                              QuestionTextField(
                                controller: _answerFieldController,
                                focus: _answerFocus,
                                onPressed: _onInputedAnswer,
                                errorText: _validateAnswer,
                                labelText:
                                    'Input the position of the answer to quesstion',
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!_isQuestionInputed)
                    SingleChildScrollView(
                      child: Button(
                        text: 'Submit\nQuestion',
                        onPressed: () {
                          _onInputedAnswer(_answerFieldController.text);
                        },
                      ),
                    ),
                  if (_isQuestionInputed)
                    Expanded(
                      child: Form(
                        key: _form,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var i = 0; i < _options!.length; i++)
                                MyFormField(
                                  autoFocus: i == 0,
                                  controller: _fieldcontroller[i],
                                  labelText: 'Option $i',
                                  onSaved: _onSavedGenerator(i),
                                  validator: _optionValidation,
                                ),
                              if (_isQuestionInputed)
                                SingleChildScrollView(
                                  child: Button(
                                    text: 'Submit\nOptions',
                                    onPressed: _submitOptions,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
