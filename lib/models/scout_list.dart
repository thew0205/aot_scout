import 'package:aot_scout/models/scout.dart';
import 'package:flutter/cupertino.dart';

class ScoutList with ChangeNotifier {
  final List<Scout> _scouts;
  int _currentScout = 0;

  ScoutList({required List<Scout> scouts})
      : _scouts = scouts,
        super();

  List<Scout> get scouts => [..._scouts];

  int get scoutNumber => _scouts.length;

  int get currentScout => _currentScout;

  void moveScout(bool direction) {
    switch (direction) {
      case true:
        if (_currentScout > _scouts.length - 1) {
          _currentScout = 0;
        } else {
          _currentScout = _currentScout + 1;
        }
        break;
      case false:
        if (_currentScout < 0) {
          _currentScout = _scouts.length;
        } else {
          _currentScout = _currentScout - 1;
        }
        break;
    }
    notifyListeners();
  }
}
