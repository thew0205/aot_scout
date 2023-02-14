import 'package:aot_scout/models/prefrence.dart';
import 'package:aot_scout/pages/setttings.dart';
import 'package:aot_scout/pages/todo_page.dart';
import 'package:aot_scout/utilities/const.dart';
import 'package:flutter/material.dart';

import 'package:aot_scout/pages/home_page.dart';
import 'package:aot_scout/pages/quiz_preview.dart';
import 'package:aot_scout/pages/titan_list_page.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Preference>(
      create: (BuildContext context) => Preference(),
      builder: (context, child) {
        return FutureBuilder<void>(
          future: context.read<Preference>().instanciatePreference(),
          builder: (context, snapshot) {
            var pref = context.watch<Preference>();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kAppDarkColor,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Container(
                  color: Colors.white,
                  child: const Text(
                    'An error occured',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: pref.themePref ? ThemeMode.dark : ThemeMode.light,
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: kAppdarkScaffold,
                  backgroundColor: kAppDarkBackgroundColor,
                  colorScheme: ColorScheme.fromSeed(
                    brightness: Brightness.dark,
                    seedColor: kAppDarkColor,
                  ),
                  fontFamily: 'CabinSketch',
                  primaryColor: kAppDarkColor,
                  // appBarTheme: AppBarTheme(
                  //   iconTheme: Theme.of(context)
                  //       .iconTheme
                  //       .copyWith(color: Colors.black),
                  //   actionsIconTheme: Theme.of(context)
                  //       .iconTheme
                  //       .copyWith(color: Colors.black),
                  //   titleTextStyle: const TextStyle(
                  //     color: Colors.black,
                  //     fontFamily: 'CabinSketch',
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   color: kAppDarkColor,
                  // ),
                  textTheme: TextTheme(
                    headline4: Theme.of(
                      context,
                    ).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CabinSketch',
                        ),
                    headline5: Theme.of(
                      context,
                    ).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CabinSketch',
                        ),
                    headline6: Theme.of(
                      context,
                    ).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CabinSketch',
                        ),
                    subtitle1: Theme.of(
                      context,
                    ).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'CabinSketch',
                        ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: kAppDarkColor,
                      textStyle:
                          Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'CabinSketch',
                              ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: kAppDarkColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontFamily: 'CabinSketch'),
                      elevation: 8,
                      primary: kAppDarkColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 20),
                      textStyle:
                          Theme.of(context).textTheme.headline6!.copyWith(
                                fontFamily: 'CabinSketch',
                              ),
                      elevation: 8,
                      primary: kAppDarkColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.red, width: 20)),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                theme: ThemeData(
                  backgroundColor: kAppBackgroundColor,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: kAppColor,
                  ),
                  fontFamily: 'CabinSketch',
                  primaryColor: kAppColor,
                  appBarTheme: AppBarTheme(
                    iconTheme: Theme.of(context)
                        .iconTheme
                        .copyWith(color: Colors.white),
                    actionsIconTheme: Theme.of(context)
                        .iconTheme
                        .copyWith(color: Colors.white),
                    titleTextStyle: const TextStyle(
                      fontFamily: 'CabinSketch',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    color: kAppColor,
                  ),
                  textTheme: TextTheme(
                    headline4: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CabinSketch',
                        ),
                    headline5: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CabinSketch',
                        ),
                    headline6: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CabinSketch',
                        ),
                    subtitle1: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CabinSketch',
                        ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: kAppColor,
                      textStyle:
                          Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'CabinSketch',
                              ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: kAppColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontFamily: 'CabinSketch'),
                      elevation: 8,
                      primary: kAppColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 20),
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontFamily: 'CabinSketch'),
                      elevation: 8,
                      primary: kAppDarkColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.red, width: 20)),
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                routes: {
                  HomePage.page: (_) => const HomePage(),
                  //QuizPage.page: (_) => const QuizPage(),
                  TitanListPage.page: (_) => const TitanListPage(),
                  QuestionPreviewPage.page: (_) => const QuestionPreviewPage(),
                  //TitanPage.page: (_) => const TitanPage(),
                  SettingsPage.page: (_) => const SettingsPage(),
                  TodoPage.page: (_) => const TodoPage(),
                },
                initialRoute: HomePage.page,
              );
            }
            return const MaterialApp(
              home: Text(
                'An error occured',
                textDirection: TextDirection.ltr,
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }
}
