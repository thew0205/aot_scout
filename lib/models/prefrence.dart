import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum Prefs {
  none,
  theme,
  onlineStorage,
  all,
}

class Preference extends ChangeNotifier {
  static const kThemePref = 'themePreference';
  static const kOnlineStoragePref = 'onlineStoragePreference';
  bool _themePref = false;
  bool _onlineStorage = false;

  late SharedPreferences _prefs;
  Preference();

  Future<void> instanciatePreference() async {
    _prefs = await SharedPreferences.getInstance();
    var tempTheme = _prefs.getBool(kThemePref);

    var tempOnlineStorage = _prefs.getBool(kOnlineStoragePref);

    _themePref = tempTheme ?? false;
    _onlineStorage = tempOnlineStorage ?? false;
    var temp = await Connectivity().checkConnectivity();
    if (temp == ConnectivityResult.none) {
      _onlineStorage = false;
      setOnlineStoragePref(false);
    }

    // if (tempOnlineStorage == null && tempTheme == null) {
    //   return Prefs.none;
    // } else if (tempOnlineStorage == null && tempTheme != null) {
    //   return Prefs.theme;
    // } else if (tempOnlineStorage != null && tempTheme == null) {
    //   return Prefs.OnlineStorage;
    // } else {
    //   return Prefs.all;
    // }
    return;
  }

  bool get themePref => _themePref;
  bool get onlineStoragePref => _onlineStorage;

  Future<void> setThemePref(bool themePref) async {
    _prefs = await SharedPreferences.getInstance();
    if (await _prefs.setBool(kThemePref, themePref)) {
      _themePref = themePref;
      notifyListeners();
    }
  }

  Future<void> setOnlineStoragePref(bool onlineStoragePref) async {
    _prefs = await SharedPreferences.getInstance();
    if (await _prefs.setBool(kOnlineStoragePref, onlineStoragePref)) {
      _onlineStorage = onlineStoragePref;
      notifyListeners();
    }
  }
}
