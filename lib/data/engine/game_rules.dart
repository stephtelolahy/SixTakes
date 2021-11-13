import 'dart:math';

import 'package:sixtakes/data/model/game.dart';

abstract class IGameRules {
  // Return bulls for a given card value
  int bullsForCard(int value);

  // Return winners if game is over
  List<String>? isGameOver(Game game);
}

class GameRules extends IGameRules {
  @override
  int bullsForCard(int value) {
    if (value % 11 == 0) {
      if (value == 55) {
        return 7;
      }
      return 5;
    }

    if (value % 5 == 0) {
      if (value % 10 == 0) {
        return 3;
      }
      return 2;
    }

    return 1;
  }

  @override
  List<String>? isGameOver(Game game) {
    if (game.players.any((e) => e.hand.isNotEmpty || e.played != null)) {
      return null;
    }

    final minBulls = game.players.map((e) => e.bulls).reduce(min);
    final winners = game.players.where((e) => e.bulls == minBulls).map((e) => e.id).toList();
    return winners;
  }
}
