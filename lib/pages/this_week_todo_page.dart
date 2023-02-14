import 'package:aot_scout/models/todolist.dart';

import 'package:aot_scout/pages/add_todo_page.dart';
import 'package:aot_scout/widgets/todo_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThisWeekTodoPage extends StatelessWidget {
  const ThisWeekTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<Todolist>();

    var todayTodos = todos.completed
        ? todos.completedOtherTodos()
        : todos.uncompletedOtherTodos();
    return Scaffold(
      body: todayTodos.isEmpty
          ? Center(
              child: Text(
                'No todo for the day.',
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: todayTodos
                    .map((todo) => ChangeNotifierProvider.value(
                          value: todo,
                          builder: (_, __) {
                            return const TodoListtile();
                          },
                        ))
                    .toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add),
        label: const Text('Add todo'),
        onPressed: () async {
          var todo = await showDialog(
              context: context,
              builder: (_) => TodoForm(
                    istoday: false,
                    todos: todos,
                  ));
          if (todo != null) {
            await todos.addTodo(todo);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('One todo has been added.'),
              ),
            );
          }
        },
      ),
    );
  }
}
