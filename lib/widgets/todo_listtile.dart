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
        child: ListTile(
          trailing: Checkbox(
            value: todo.completed,
            onChanged: (bool? val) async {
              //  await Future.delayed(const Duration(milliseconds: 500));
              await todos.completeTodo(todo);
            },
          ),
          leading: SizedBox(
              child: Text(
            todo.importanceToString,
            textAlign: TextAlign.center,
          )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          //textColor: Theme.of(context).primaryColor,
          tileColor: Theme.of(context).backgroundColor,
          title: Text(
            todo.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: ExpansionTile(
            title: Text(todo.description),
            children: [Text('${todo.toBeCompleted}')],
          ),
        ),
        onDismissed: (dismissedDirection) async {
          await todos.deleteTodo(todo);
        },
      ),
    );
  }
}
