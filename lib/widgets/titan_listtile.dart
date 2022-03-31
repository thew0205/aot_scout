import 'package:aot_scout/models/titan.dart';
import 'package:aot_scout/pages/titan_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitanListTile extends StatelessWidget {
  const TitanListTile({
    Key? key,
    required this.titan,
  }) : super(key: key);

  final Titan titan;

  VoidCallback tileAction(BuildContext context, Widget page) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        //textColor: Theme.of(context).primaryColor,
        tileColor: Theme.of(context).backgroundColor,
        title: Text(
          titan.titanName,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(titan.inheritorName),
        trailing: CircleAvatar(
          backgroundColor: Colors.white, // Theme.of(context).backgroundColor,
          backgroundImage: AssetImage(titan.inheritorImage),
        ),
        leading: Hero(
          tag: titan.titanName,
          child: CircleAvatar(
            backgroundImage: AssetImage(titan.titanImage),
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ),
        onTap: tileAction(
          context,
          ChangeNotifierProvider<Titan>.value(
            value: titan,
            builder: (BuildContext context, Widget? child) {
              return const TitanPage();
            },
          ),
        ),
      ),
    );
  }
}
