import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/game.dart';

abstract class IGameEngine {
  BehaviorSubject<Game> get stateSubject;
  Future<void> play(String player, int card);
}

class GameEngine extends IGameEngine {
  final GameRules _rules;
  final Queue<GameEvent> _commands;
  final int _delayMillis;

  @override
  final BehaviorSubject<Game> stateSubject;

  GameEngine({required Game initialState, required GameRules rules, int delayMillis = 0})
      : stateSubject = BehaviorSubject<Game>.seeded(initialState),
        _rules = rules,
        _commands = Queue(),
        _delayMillis = delayMillis;

  @override
  Future<void> play(String player, int card) async {
    debugPrint('\nplay $player $card');

    _commands.add(GameEventSelectCard(player: player, card: card));
    await _update();
  }

  Future<void> _update() async {
    final Game state = stateSubject.value;

    if (state.winner != null) {
      return;
    }

    if (_commands.isEmpty) {
      _queueTriggered(state);
    }

    if (_commands.isEmpty) {
      return;
    }

    final event = _commands.removeFirst();
    await _dispatch(event, state);
    await Future.delayed(Duration(milliseconds: _delayMillis));

    await _update();
  }

  void _queueTriggered(Game state) {
    final events = _rules.triggered(state);
    _commands.addAll(events);
  }

  Future<void> _dispatch(GameEvent event, Game state) async {
    event.dispatch(state);
    stateSubject.add(state);
    debugPrint('\n$event Pending=${_commands.length}');
    debugPrint('players: ${state.players.map((e) => '${e.id}:${e.played?.value}').join('; ')}');
    debugPrint(
        'rows: ${state.rows.map((e) => '[${e.cards.map((e) => e.value).join(',')}]').join('; ')}');
  }
}
