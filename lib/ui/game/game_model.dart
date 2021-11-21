import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:sixtakes/data/engine/deck.dart';
import 'package:sixtakes/data/engine/engine.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/engine/setup.dart';
import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/data/model/user.dart';
import 'package:sixtakes/misc/list_extensions.dart';

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
  List<DisplayableCard> _cards = [];

  List<DisplayableCard> get cards => _cards;

  late IGameEngine _engine;

  void update() {
    if (_cards.isEmpty) {
      _initialize();
    } else {
      _randomMove();
    }
  }

  void _initialize() {
    final users = List.generate(
      4,
      (idx) => User(
        id: 'p$idx',
        name: 'user$idx',
        photoURL: '',
        score: 0,
      ),
    );
    final deck = GameDeck().createDeck();
    final state = GameSetup().createGame(users, deck);
    _engine = GameEngine(initialState: state, rules: GameRules(), eventDurationMillis: 600);
    _engine.stateSubject.listen((state) {
      _cards = _mapState(state);
      notifyListeners();
    });
  }

  static List<DisplayableCard> _mapState(Game state) {
    List<DisplayableCard> result = [];
    for (var playerIndex = 0; playerIndex < state.players.length; playerIndex++) {
      final player = state.players[playerIndex];
      final card = player.played;
      if (card != null) {
        result.add(
          DisplayableCard(
              value: card.value,
              bulls: card.bulls,
              covered: state.select,
              renderKey: 'player$playerIndex'),
        );
      }

      for (var card in player.gathered) {
        result.add(
          DisplayableCard(
            value: card.value,
            bulls: card.bulls,
            hidden: true,
            renderKey: 'player$playerIndex',
          ),
        );
      }
    }

    for (var rowIndex = 0; rowIndex < state.rows.length; rowIndex++) {
      final rowCards = state.rows[rowIndex].cards;
      for (var colIndex = 0; colIndex < rowCards.length; colIndex++) {
        final card = rowCards[colIndex];
        result.add(
          DisplayableCard(
            value: card.value,
            bulls: card.bulls,
            renderKey: 'row$rowIndex$colIndex',
          ),
        );
      }
    }

    return result;
  }

  void _randomMove() {
    final state = _engine.stateSubject.value;
    if (state.select) {
      final actor = state.players.firstWhereOrNull((e) => e.played == null);
      if (actor != null) {
        _engine.play(actor.id, actor.hand.randomElement().value);
      }
    }
  }
}
