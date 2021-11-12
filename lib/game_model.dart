import 'dart:math';

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
          position: const Rectangle(100, 100, 50, 80),
        ),
      ),
    );
  }

  void update() {
    _cards[0].position = const Rectangle(100, 100, 100, 20);
    _cards[0].opacity = 1.0;
    notifyListeners();
  }
}
