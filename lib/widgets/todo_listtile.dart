import 'package:aot_scout/models/todolist.dart';
import 'package:flutter/material.dart';

import 'package:aot_scout/models/todo.dart';
import 'package:provider/provider.dart';

class TodoListtile extends StatelessWidget {
  const TodoListtile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.read<Todolist>();
    final todo = context.watch<Todo>();
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Dismissible(
        key: ObjectKey(todo.id),
        child: ExpansionTile(
          trailing: Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: todo.completed,
            onChanged: (bool? val) async {
              await todos.changeTodoCompletion(todo);
            },
          ),
          leading: SizedBox(
            child: Text(
              todo.importanceToString,
              textAlign: TextAlign.center,
            ),
          ),
          textColor:
              Theme.of(context).textTheme.headline5!.color ?? Colors.black,
          backgroundColor: Theme.of(context).backgroundColor,
          collapsedBackgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            todo.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text(todo.description),
          children: [Text('${todo.toBeCompleted}')],
        ),
        onDismissed: (dismissedDirection) async {
          await todos.deleteTodo(todo);
        },
      ),
    );
  }
}
