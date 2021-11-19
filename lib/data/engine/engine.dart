import 'dart:async';

import 'package:sixtakes/data/model/game.dart';

abstract class IGameEngine {
  Stream<Game> get state;

  play(String player, int card);
}

class GameEngine extends IGameEngine {
  final StreamController<Game> _controller = StreamController<Game>();

  @override
  Stream<Game> get state => _controller.stream;

  initialize(Game aState) {
    _controller.add(aState);
  }

  @override
  play(String player, int card) {}
}
