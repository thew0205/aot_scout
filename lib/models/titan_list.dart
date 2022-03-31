import 'package:aot_scout/models/titan.dart';
import 'package:flutter/foundation.dart';

class TitanList with ChangeNotifier {
  final List<Titan> _titans;
  final int _currentTitan = 0;

  TitanList({required titans})
      : _titans = titans,
        super();

  List<Titan> get titans => [..._titans];

  // void moveTitan(bool direction) {
  //   switch (direction) {
  //     case true:
  //       _currentTitan = _currentTitan + 1;
  //       break;
  //     case false:
  //       _currentTitan = _currentTitan - 1;
  //   }
  //   notifyListeners();
  // }

  int get currentTitan => _currentTitan;

  int get titanNumber => _titans.length;
}
