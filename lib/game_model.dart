import 'package:flutter/widgets.dart';

class GameModel extends ChangeNotifier {
  bool _selected = false;

  bool get selected => _selected;

  void update() {
    _selected = !_selected;
    notifyListeners();
  }
}
