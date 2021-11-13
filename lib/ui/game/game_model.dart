import 'dart:ui';

import 'package:flutter/widgets.dart';

class CardData {
  final int value;
  final int bulls;
  bool covered;
  bool hidden;
  Rect position;

  CardData({
    required this.value,
    required this.bulls,
    this.covered = false,
    this.hidden = false,
    required this.position,
  });
}

class GameModel extends ChangeNotifier {
  final List<CardData> _cards = [];

  List<CardData> get cards => _cards;

  void init() {
    _cards.addAll(
      List.generate(
        3,
        (idx) => CardData(
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
