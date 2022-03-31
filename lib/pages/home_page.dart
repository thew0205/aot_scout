import 'package:aot_scout/pages/quiz_preview.dart';
import 'package:aot_scout/pages/todo_page.dart';
import 'package:aot_scout/widgets/button_widget.dart';

import 'package:flutter/material.dart';

import 'setttings.dart';
import 'titan_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const page = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.landscape
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'assets/image/wings of freedom.png',
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Button(
                            text: 'Quiz Page',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(QuestionPreviewPage.page),
                          ),
                          Button(
                            text: 'Todo Page',
                            onPressed: () =>
                                Navigator.of(context).pushNamed(TodoPage.page),
                          ),
                          Button(
                            text: 'Titan Page',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(TitanListPage.page),
                          ),
                          Button(
                            text: 'Setting Page',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(SettingsPage.page),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'assets/image/wings of freedom.png',
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Button(
                            text: 'Quiz Page',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(QuestionPreviewPage.page),
                          ),
                          Button(
                            text: 'Todo Page',
                            onPressed: () =>
                                Navigator.of(context).pushNamed(TodoPage.page),
                          ),
                          Button(
                            text: 'Titan Page',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(TitanListPage.page),
                          ),
                          Button(
                            text: 'Setting Page',
                            onPressed: () => Navigator.of(context)
                                .pushNamed(SettingsPage.page),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
