import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:sixtakes/card_model.dart';

class GameModel extends ChangeNotifier {
  final List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  void init() {
    _cards.addAll(
      List.generate(
        3,
        (idx) => CardModel(
          id: "card$idx",
          value: idx + 1,
          bulls: 1,
          position: const Rect.fromLTWH(100, 100, 50, 80),
        ),
      ),
    );
  }

  void update() {
    _cards[0].position = _cards[0].position.translate(50, 0);
    notifyListeners();
  }
}
