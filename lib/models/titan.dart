import 'package:flutter/cupertino.dart';

class Titan with ChangeNotifier {
  final String _titanName;

  final String _inheritorName;
  bool _form = true;

  Titan({required String titanName, required String inheritorName})
      : _titanName = titanName,
        _inheritorName = inheritorName;

  bool get form => _form;

  void changeForm() {
    _form = !_form;
    notifyListeners();
  }

  String get formName => _form ? _titanName : _inheritorName;

  String get formImage =>
      'assets/image/${_form ? _titanName : _inheritorName}.jpg';

  String get titanName => _titanName;

  String get titanImage => 'assets/image/$_titanName.jpg';

  String get inheritorName => _inheritorName;

  String get inheritorImage => 'assets/image/$_inheritorName.jpg';
}
