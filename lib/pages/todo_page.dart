import 'package:aot_scout/models/todolist.dart';
import 'package:aot_scout/pages/this_week_todo_page.dart';
import 'package:aot_scout/pages/today_todo.dart';
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
        return const TodoPageWidget();
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
  late final Future future;
  @override
  void initState() {
    super.initState();
    future = context.read<Todolist>().initializeTodos();
  }

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Scaffold(body: Text(snapshot.error.toString()));
          } else {
            return Scaffold(
              body: currentIndex == 0
                  ? const TodayTodoPage()
                  : const ThisWeekTodoPage(),
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
      },
    );
  }
}
