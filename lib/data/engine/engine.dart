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
  final Queue<GameEvent> _queue;
  final int _eventDurationMillis;

  @override
  final BehaviorSubject<Game> stateSubject;

  GameEngine({required Game initialState, required GameRules rules, int eventDurationMillis = 0})
      : stateSubject = BehaviorSubject<Game>.seeded(initialState),
        _rules = rules,
        _queue = Queue(),
        _eventDurationMillis = eventDurationMillis;

  @override
  Future<void> play(String player, int card) async {
    debugPrint('\nplay $player $card');

    _queue.add(GameEventSelectCard(player: player, card: card));
    await _update();
  }

  Future<void> _update() async {
    final Game state = stateSubject.value;

    if (state.winner != null) {
      return;
    }

    if (_queue.isEmpty) {
      _queueTriggered(state);
    }

    if (_queue.isEmpty) {
      return;
    }

    final event = _queue.removeFirst();
    await _dispatch(event, state);
    await Future.delayed(Duration(milliseconds: _eventDurationMillis));
    await _update();
  }

  void _queueTriggered(Game state) {
    final events = _rules.triggered(state);
    _queue.addAll(events);
  }

  Future<void> _dispatch(GameEvent event, Game state) async {
    event.dispatch(state);
    stateSubject.add(state);
    debugPrint('\n$event Pending=${_queue.length}');
    debugPrint('players: ${state.players.map((e) => '${e.id}:${e.played?.value}').join('; ')}');
    debugPrint(
        'rows: ${state.rows.map((e) => '[${e.cards.map((e) => e.value).join(',')}]').join('; ')}');
  }
}
