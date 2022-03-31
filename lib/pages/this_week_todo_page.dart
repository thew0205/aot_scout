import 'package:aot_scout/models/todolist.dart';
import 'package:aot_scout/widgets/todo_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_todo_page.dart';

class ThisweekTodoPage extends StatelessWidget {
  const ThisweekTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<Todolist>();
    return Scaffold(
      appBar: AppBar(title: const Text('THIS WEEK\'S TODO')),
      body: SingleChildScrollView(
        child: todos.todos.isEmpty
            ? Center(
                child: Text(
                  'Add todos',
                  style: Theme.of(context).textTheme.headline5,
                ),
              )
            : Column(
                children: todos.thisWeekTodos
                    .map(
                      (todo) => ChangeNotifierProvider.value(
                        value: todo,
                        builder: (_, __) {
                          return const TodoListtile();
                        },
                      ),
                    )
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add todo'),
        onPressed: () async {
          var todo = await Navigator.push<Map<String, Object>>(
              context,
              MaterialPageRoute(
                  builder: (_) => const TodoForm(istoday: false)));
          if (todo != null) await todos.addTodo(todo);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('One todo has been added.'),
          ));
        },
      ),
    );
  }
}
