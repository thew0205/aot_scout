import 'package:aot_scout/models/prefrence.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String page = '/SettingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const SettingsWidget(),
    );
  }
}

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pref = context.watch<Preference>();
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                  value: pref.themePref, //inactiveThumbColor: ,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  splashRadius: 20,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    pref.setThemePref(value);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enable online storage',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                  value: pref.onlineStoragePref, //inactiveThumbColor: ,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  splashRadius: 20,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    pref.setOnlineStoragePref(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
