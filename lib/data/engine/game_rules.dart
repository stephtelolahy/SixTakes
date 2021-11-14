import 'dart:math';

import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

abstract class IGameRules {
  int bullsForCard(int value);
  List<String>? winners(Game state);
  List<GameEvent> triggered(Game state);
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
  List<String>? winners(Game state) {
    if (state.players.any((e) => e.hand.isNotEmpty || e.played != null)) {
      return null;
    }

    final minBulls = state.players.map((e) => e.bulls).reduce(min);
    return state.players.where((e) => e.bulls == minBulls).map((e) => e.id).toList();
  }

  @override
  List<GameEvent> triggered(Game state) {
    if (state.phase == 0 && state.players.every((e) => e.played != null)) {
      return [GameEventUncoverCards()];
    }

    return [];
  }
}
