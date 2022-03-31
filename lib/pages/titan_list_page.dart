import 'package:aot_scout/models/titan.dart';
import 'package:aot_scout/models/titan_list.dart';

import 'package:aot_scout/widgets/titan_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitanListPage extends StatelessWidget {
  const TitanListPage({Key? key}) : super(key: key);

  static const String page = '/TitanListPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              'The Nine Titans',
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => TitanList(titans: [
          Titan(
            titanName: 'Founding Titan',
            inheritorName: 'Eren Yeager',
          ),
          Titan(
            titanName: 'Armored Titan',
            inheritorName: 'Reiner Braun',
          ),
          Titan(
            titanName: 'Attack Titan',
            inheritorName: 'Eren Yeager',
          ),
          Titan(
            titanName: 'Beast Titan',
            inheritorName: 'Zeke Yeager',
          ),
          Titan(
            titanName: 'War Hammer Titan',
            inheritorName: 'Eren Yeager',
          ),
          Titan(
            titanName: 'Female Titan',
            inheritorName: 'Annie Leonhart',
          ),
          Titan(
            titanName: 'Colossal Titan',
            inheritorName: 'Bertolt Goover',
          ),
          Titan(
            titanName: 'Jaw Titan',
            inheritorName: 'Porco Galliard',
          ),
          Titan(
            titanName: 'Cart Titan',
            inheritorName: 'Pieck Finger',
          ),
        ]),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
            child: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  var titans = context.read<TitanList>();
                  return Column(
                    children: [
                      for (var titan in titans.titans)
                        ChangeNotifierProvider<Titan>.value(
                          value: titan,
                          builder: (context, _) => TitanListTile(
                            titan: titan,
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
