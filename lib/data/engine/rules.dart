import 'dart:math';

import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

abstract class IGameRules {
  List<GameEvent> triggered(Game state);
}

class GameRules extends IGameRules {
  @override
  List<GameEvent> triggered(Game state) {
    final winner = _winners(state);
    if (winner != null) {
      return [GameEventGameOver(winner: winner)];
    }

    if (state.select && state.players.every((e) => e.played != null)) {
      return [GameEventUncoverCards()];
    }

    if (!state.select && state.players.every((e) => e.played == null)) {
      return [GameEventNextTurn()];
    }

    if (!state.select) {
      final minPlayedCard = state.players.map((e) => e.played!.value).reduce(min);
      final minPlayer = state.players.firstWhere((e) => e.played!.value == minPlayedCard);
      return _putSelectedCard(state, minPlayer, minPlayedCard);
    }

    return [];
  }

  List<String>? _winners(Game state) {
    if (state.players.any((e) => e.hand.isNotEmpty || e.played != null)) {
      return null;
    }

    final minBulls = state.players.map((e) => e.bulls).reduce(min);
    return state.players.where((e) => e.bulls == minBulls).map((e) => e.id).toList();
  }

  List<GameEvent> _putSelectedCard(Game state, Player actor, int card) {
    final nearestValue =
        state.rows.map((e) => e.cards.last.value).where((e) => e < card).reduce(max);
    final rowIndex = state.rows.indexWhere((e) => e.cards.last.value == nearestValue);
    return [GameEventPutRow(player: actor.id, row: rowIndex)];
  }
}
