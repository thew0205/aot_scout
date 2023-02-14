import 'package:aot_scout/models/todo.dart';
import 'package:aot_scout/models/todolist.dart';
import 'package:aot_scout/widgets/button_widget.dart';
import 'package:aot_scout/widgets/fieldform.dart';
import 'package:aot_scout/widgets/my_dropdownwidget.dart';
import 'package:aot_scout/widgets/todo_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatefulWidget {
  const TodoForm(
      {Key? key, required this.istoday, this.todo, required this.todos})
      : super(key: key);
  final bool istoday;
  final Todo? todo;
  final Todolist todos;
  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late final Todolist todos;
  final _form = GlobalKey<FormState>();
  late final String name;
  late final String description;
  DateTime? chosenDateTime = DateTime.now();
  TimeOfDay time = const TimeOfDay(hour: 23, minute: 59);
  Importance importance = Importance.important;
  String label = "Personal";
  late final DateTime toBeCompleted;
  late final Todo? todo;
  late final bool isNew;
  @override
  void initState() {
    super.initState();
    todo = widget.todo;
    isNew = todo == null;
    todos = widget.todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyFormField(
                        initialValue: isNew ? null : todo!.name,
                        autoFocus: true,
                        labelText: 'Name of todo',
                        onSaved: (value) {
                          name = value!;
                        },
                        validator: (String? value) {
                          if (value == null) {
                            return 'Enter a option';
                          } else if (value.isEmpty) {
                            return 'Enter a valid option';
                          } else {
                            return null;
                          }
                        },
                      ),
                      MyFormField(
                        initialValue: isNew ? null : todo!.description,
                        maxlines: 3,
                        labelText: 'Descprition of todo',
                        onSaved: (value) {
                          description = value!;
                        },
                        textInputAction: TextInputAction.newline,
                        validator: (String? value) {
                          if (value == null) {
                            return 'Enter a option';
                          } else if (value.isEmpty) {
                            return 'Enter a valid option';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('Importance'),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: MyDropDownWidget<Importance>(
                              items:  const [
                                Importance.important,
                                Importance.leastImportant,
                                Importance.veryImportant
                              ]
                              ,itemToString: stringFromImportance,
                              initialValue: importance,
                              onChanged: (value) {
                                importance = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Label'),
                          ),
                          Expanded(
                            child: MyDropDownWidget<String>(
                                items: todos.labels,
                                initialValue: todos.label,
                                onChanged: (value) {
                                  label = value!;
                                }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () async {
                                time = await showTimePicker(
                                      context: context,
                                      initialTime: isNew
                                          ? const TimeOfDay(
                                              hour: 23, minute: 59)
                                          : TimeOfDay(
                                              hour: todo!.toBeCompleted.hour,
                                              minute:
                                                  todo!.toBeCompleted.minute),
                                    ) ??
                                    const TimeOfDay(hour: 23, minute: 59);
                              },
                              child: Text(
                                'Select time',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Text(
                              '${time.hour}: ${time.minute}',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      ),
                      // if (!widget.istoday)
                      TextButton(
                        onPressed: () async {
                          chosenDateTime = await showDatePicker(
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 366)),
                                context: context,
                                initialDate: isNew
                                    ? DateTime.now()
                                    : todo!.toBeCompleted,
                              ) ??
                              DateTime.now();
                        },
                        child: const Text('Select date to be completed'),
                      ),
                      Button(
                        text: 'Submit todo',
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            if (widget.istoday) {
                              _form.currentState!.save();
                              chosenDateTime = DateTime.now();
                              toBeCompleted = DateTime(
                                chosenDateTime!.year,
                                chosenDateTime!.month,
                                chosenDateTime!.day,
                                time.hour,
                                time.minute,
                              );
                            } else {
                              if (chosenDateTime != null) {
                                _form.currentState!.save();
                                toBeCompleted = DateTime(
                                  chosenDateTime!.year,
                                  chosenDateTime!.month,
                                  chosenDateTime!.day,
                                  time.hour,
                                  time.minute,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 500),
                                    content: Text(
                                      'Input a date to be completed',
                                    ),
                                  ),
                                );
                                return;
                              }
                            }
                            var todo = {
                              Todo.kName: name,
                              Todo.kDescription: description,
                              Todo.kToBeCompleted: toBeCompleted.toString(),
                              Todo.kImportance:
                                  Todo.importanceToInt(importance),
                              Todo.kCompleted: 0,
                              Todo.kLabel: label
                            };
                            Navigator.pop(context, todo);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
