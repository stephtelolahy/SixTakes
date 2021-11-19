import 'package:sixtakes/data/engine/deck.dart';
import 'package:sixtakes/data/engine/engine.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/engine/setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/data/model/user.dart';
import 'package:collection/collection.dart';

import 'package:sixtakes/misc/list_extensions.dart';

void main() {
  late GameEngine sut;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final users =
        List.generate(4, (idx) => User(id: 'p$idx', name: 'user$idx', photoURL: '', score: 0));
    final deck = GameDeck().createDeck();
    final state = GameSetup().createGame(users, deck);
    sut = GameEngine(initialState: state, rules: GameRules());
  });

  test('emit initial state', () async {
    // Given
    Game? lastState;
    int emitCout = 0;

    // When
    sut.stateSubject.listen((state) {
      lastState = state;
      emitCout++;
    });
    await Future.delayed(const Duration(seconds: 1), () {});

    // Assert
    expect(lastState, isNotNull);
    expect(emitCout, equals(1));
  });

  test('game should complete', () async {
    // Given
    var isGameOver = false;

    // When
    sut.stateSubject.listen((state) {
      if (state.select) {
        final actor = state.players.firstWhereOrNull((e) => e.played == null);
        if (actor != null) {
          sut.play(actor.id, actor.hand.randomElement().value);
        }
      }

      isGameOver = state.winner != null;
    });

    await Future.delayed(const Duration(seconds: 1), () {});

    // Assert
    expect(isGameOver, isTrue);
  });
}
