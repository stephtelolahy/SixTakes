import 'package:flutter/widgets.dart';

class DisplayableCard {
  final int value;
  final int bulls;
  bool covered;
  bool hidden;
  String renderKey;

  DisplayableCard({
    required this.value,
    required this.bulls,
    this.covered = false,
    this.hidden = false,
    required this.renderKey,
  });
}

class GameModel extends ChangeNotifier {
  final List<DisplayableCard> _cards = [];

  List<DisplayableCard> get cards => _cards;

  void update() {
    if (_cards.isEmpty) {
      final card = DisplayableCard(value: 1, bulls: 1, renderKey: 'player0');
      _cards.add(card);
    } else {
      _cards[0].renderKey = 'player1';
    }
    notifyListeners();
  }
}
