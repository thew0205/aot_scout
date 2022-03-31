import 'package:aot_scout/models/todolist.dart';
import 'package:aot_scout/pages/add_todo_page.dart';
import 'package:aot_scout/widgets/todo_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayTodoPage extends StatefulWidget {
  const TodayTodoPage({Key? key}) : super(key: key);

  @override
  State<TodayTodoPage> createState() => _TodayTodoPageState();
}

class _TodayTodoPageState extends State<TodayTodoPage> {
  var isComplete = false;

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<Todolist>();

    var todayTodos =
        isComplete ? todos.completedTodayTodos : todos.uncompletedTodayTodos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isComplete = !isComplete;
              });
            },
            child: Text(
              isComplete ? "uncompleted" : "completd",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
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
              context: context, builder: (_) => const TodoForm(istoday: true));
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
