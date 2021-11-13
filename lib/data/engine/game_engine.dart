import 'dart:async';

import 'package:sixtakes/data/model/game.dart';

abstract class IGameEngine {
  Stream<Game> get gameStream;

  play(String player, int card);
}

class GameEngine extends IGameEngine {
  final StreamController<Game> _controller = StreamController<Game>();

  @override
  Stream<Game> get gameStream => _controller.stream;

  initialize(Game state) {
    _controller.add(state);
  }

  @override
  play(String player, int card) {}
}
