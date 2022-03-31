import 'package:aot_scout/models/todolist.dart';
import 'package:aot_scout/pages/this_week_todo_page.dart';
import 'package:aot_scout/pages/today_todo.dart';
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
    future = context.read<Todolist>().getTodo();
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
            return Text(snapshot.error.toString());
          } else {
            return Scaffold(
              body: currentIndex == 0
                  ? const TodayTodoPage()
                  : const ThisweekTodoPage(),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Theme.of(context).primaryColor,
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.today),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor: currentIndex == 0
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).unselectedWidgetColor,
                              radius: 6,
                              child: Builder(
                                builder: (context) {
                                  return FittedBox(
                                    child: Text(
                                      '${context.watch<Todolist>().uncompletedTodayTodos.length}',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: currentIndex == 0
                                                ? Colors.white
                                                : Colors.white54,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      label:
                          'Today ${context.watch<Todolist>().uncompletedTodayTodos.length}'),
                  BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.next_week),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor: currentIndex == 0
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).unselectedWidgetColor,
                              radius: 6,
                              child: Builder(
                                builder: (context) {
                                  return FittedBox(
                                    child: Text(
                                      '${context.watch<Todolist>().uncompletedTodayTodos.length}',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: currentIndex == 0
                                                ? Colors.white
                                                : Colors.white54,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      label:
                          'Today ${context.watch<Todolist>().uncompletedTodayTodos.length}'),
                ],
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
