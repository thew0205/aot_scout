import 'dart:async';

import 'package:aot_scout/models/todolist.dart';
import 'package:aot_scout/pages/this_week_todo_page.dart';
import 'package:aot_scout/pages/today_todo_page.dart';
import 'package:aot_scout/widgets/button_widget.dart';
import 'package:aot_scout/widgets/fieldform.dart';
import 'package:aot_scout/widgets/todo_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);
  static const page = '/TodoPage';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Todolist>(
      create: (_) => Todolist(),
      builder: (context, __) {
        return FutureBuilder(
          future: context.read<Todolist>().initializeTodos(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ));
            } else {
              if (snapshot.hasError) {
                return Scaffold(
                    appBar: AppBar(),
                    body: Text(
                      snapshot.error.toString(),
                    ));
              } else {
                return const TodoPageWidget();
              }
            }
          },
        );
      },
    );
  }
}

class TodoPageWidget extends StatefulWidget {
  const TodoPageWidget({Key? key}) : super(key: key);

  @override
  State<TodoPageWidget> createState() => _TodoPageWidgetState();
}

class _TodoPageWidgetState extends State<TodoPageWidget> {
  @override
  void initState() {
    super.initState();
  }

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final todos = context.read<Todolist>();
    String? label;
    final _dropdown = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: todos.setCompleted,
            icon: Text(
              todos.completed ? "uncompleted" : "completd",
              style: Theme.of(context).textTheme.subtitle1!,
            ),
          )
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              key: _dropdown,
              value: todos.label,
              items: todos.labels
                  .map(
                    (label) => DropdownMenuItem<String>(
                      child: Text(label,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.blueGrey
                                      : Colors.grey)),
                      value: label,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  todos.label = value ?? todos.label;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final controller = TextEditingController();
                final _form = GlobalKey<FormState>();
                final label = await showDialog<String>(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: Column(
                          children: [
                            Form(
                              key: _form,
                              child: MyFormField(
                                controller: controller,
                                labelText: "Enter a new label",
                                onSaved: (value) {
                                  Navigator.pop(context, controller.text);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter valid name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Button(
                                  text: 'Cancel',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  text: 'Submit label',
                                  onPressed: () {
                                    if (_form.currentState!.validate()) {
                                      _form.currentState!.save();
                                      Navigator.pop(context, controller.text);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
                if (label != null) {
                  todos.addLabel(label);
                  todos.label = label;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('A new label added'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
      body:
          currentIndex == 0 ? const TodayTodoPage() : const ThisWeekTodoPage(),
      bottomNavigationBar: TodoBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
