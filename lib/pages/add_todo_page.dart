import 'package:aot_scout/models/todo.dart';
import 'package:aot_scout/widgets/button_widget.dart';
import 'package:aot_scout/widgets/option_fieldform.dart';
import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key, required this.istoday, this.todo})
      : super(key: key);
  final bool istoday;
  final Todo? todo;
  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _form = GlobalKey<FormState>();
  late final String name;
  late final String description;
  DateTime? chosenDateTime;
  TimeOfDay time = const TimeOfDay(hour: 23, minute: 59);
  late int importance = 0;
  late final DateTime toBeCompleted;
  late final Todo? todo;
  late final bool isNew;
  @override
  void initState() {
    super.initState();
    todo = widget.todo;
    isNew = todo == null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Form(
            key: _form,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Level of importance'),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        isDense: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 6,
                            ),
                          ),
                        ),
                        value:
                            isNew ? 1 : Todo.importanceToInt(todo!.importance),
                        items: const [
                          DropdownMenuItem<int>(
                            child: Text('Least important'),
                            value: 0,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('Important'),
                            value: 1,
                          ),
                          DropdownMenuItem<int>(
                            child: Text('Very important'),
                            value: 2,
                          )
                        ],
                        onChanged: (value) {
                          importance = value!;
                        },
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    time = await showTimePicker(
                          context: context,
                          initialTime: isNew
                              ? const TimeOfDay(hour: 23, minute: 59)
                              : TimeOfDay(
                                  hour: todo!.toBeCompleted.hour,
                                  minute: todo!.toBeCompleted.minute),
                        ) ??
                        const TimeOfDay(hour: 23, minute: 59);
                  },
                  child: const Text('Select time'),
                ),
                if (!widget.istoday)
                  TextButton(
                    onPressed: () async {
                      chosenDateTime = await showDatePicker(
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 366)),
                        context: context,
                        initialDate:
                            isNew ? DateTime.now() : todo!.toBeCompleted,
                      );
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
                        Todo.kDecription: description,
                        Todo.kToBeCompleted: toBeCompleted.toString(),
                        Todo.kImportance: importance,
                        Todo.kCompleted: 0,
                      };
                      Navigator.pop(context, todo);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
