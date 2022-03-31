import 'package:aot_scout/models/todolist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoBottomNavigationBar extends StatelessWidget {
  const TodoBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      onTap: onTap,
    );
  }
}
