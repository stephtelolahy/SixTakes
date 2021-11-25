// ignore: implementation_imports
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:sixtakes/data/engine/deck.dart';
import 'package:sixtakes/data/engine/engine.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/engine/setup.dart';
import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/data/model/user.dart';
import 'package:sixtakes/misc/list_extensions.dart';
import 'package:sixtakes/ui/game/widgets/animated_card_data.dart';

class GameModel extends ChangeNotifier {
  bool _loaded = false;
  List<AnimatedCardData> _cards = [];
  List<Player> _others = [];
  late Player _you;
  late IGameEngine _engine;
  final _controlled = 'p0';

  bool get loaded => _loaded;
  List<AnimatedCardData> get cards => _cards;
  List<Player> get others => _others;
  Player get you => _you;

  void initialize() {
    final users = List.generate(
      7,
      (idx) => User(
        id: 'p$idx',
        name: 'user$idx',
        photoURL: '',
        score: 0,
      ),
    );
    final deck = GameDeck().createDeck();
    final state = GameSetup().createGame(users, deck);
    _engine = GameEngine(initialState: state, rules: GameRules(), eventDurationMillis: 1000);
    _engine.stateSubject.listen((state) {
      _cards = _buildDisplayableCards(state);
      _you = state.players.firstWhere((e) => e.id == _controlled);
      _others = state.players.where((e) => e.id != _controlled).toList();
      _loaded = true;
      notifyListeners();
    });
  }

  static List<AnimatedCardData> _buildDisplayableCards(Game state) {
    List<AnimatedCardData> result = [];
    for (var player in state.players) {
      final card = player.played;
      if (card != null) {
        result.add(
          AnimatedCardData(
            value: card.value,
            bulls: card.bulls,
            covered: state.select,
            renderKey: player.id,
          ),
        );
      }

      for (var card in player.gathered) {
        result.add(
          AnimatedCardData(
            value: card.value,
            bulls: card.bulls,
            hidden: true,
            renderKey: player.id,
          ),
        );
      }
    }

    for (var rowIndex = 0; rowIndex < state.rows.length; rowIndex++) {
      final rowCards = state.rows[rowIndex].cards;
      for (var colIndex = 0; colIndex < rowCards.length; colIndex++) {
        final card = rowCards[colIndex];
        result.add(
          AnimatedCardData(
            value: card.value,
            bulls: card.bulls,
            renderKey: 'row$rowIndex$colIndex',
          ),
        );
      }
    }

    return result;
  }

  void play(int card) async {
    final state = _engine.stateSubject.value;
    if (state.select) {
      final actor = state.players.firstWhereOrNull((e) => e.played == null && e.id == _controlled);
      if (actor != null) {
        await _engine.play(actor.id, card);
        _aiMoves();
      }
    }
  }

  void _aiMoves() async {
    Game state;
    do {
      state = _engine.stateSubject.value;
      if (state.winner != null) {
        return;
      }

      final actor = state.players.firstWhereOrNull((e) => e.played == null && e.id != _controlled);
      if (actor != null) {
        final card = actor.hand.randomElement().value;
        await _engine.play(actor.id, card);
      } else {
        break;
      }
    } while (state.select);
  }
}
