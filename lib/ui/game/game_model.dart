import 'dart:ui';

import 'package:flutter/widgets.dart';

class DisplayableCard {
  final int value;
  final int bulls;
  bool covered;
  bool hidden;
  Rect position;

  DisplayableCard({
    required this.value,
    required this.bulls,
    this.covered = false,
    this.hidden = false,
    required this.position,
  });
}

class GameModel extends ChangeNotifier {
  final List<DisplayableCard> _cards = [];

  List<DisplayableCard> get cards => _cards;

  void init() {
    _cards.addAll(
      List.generate(
        3,
        (idx) => DisplayableCard(
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
