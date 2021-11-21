import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('uncover cards if all players selected a card', () {
    // Given
    final state = Game(select: true, rows: [], players: [
      Player(
          id: 'p1',
          name: '',
          photoURL: '',
          hand: [],
          gathered: [],
          played: const PlayingCard(value: 44, bulls: 1)),
      Player(
          id: 'p2',
          name: '',
          photoURL: '',
          hand: [],
          gathered: [],
          played: const PlayingCard(value: 11, bulls: 1))
    ]);

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(effects, equals([GameEventUncoverCards()]));
  });

  test('do nothing if not all players selected a card', () {
    // Given
    final state = Game(select: true, rows: [], players: [
      Player(
        id: 'p1',
        name: '',
        photoURL: '',
        hand: [const PlayingCard(value: 39, bulls: 1)],
        gathered: [],
      ),
      Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [])
    ]);

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(effects, isEmpty);
  });
}
