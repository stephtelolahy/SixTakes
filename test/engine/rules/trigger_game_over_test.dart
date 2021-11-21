import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('single winner if one player has the biggest number of bulls', () {
    // Given
    final state = Game(
      select: false,
      rows: [],
      players: [
        Player(
            id: 'p1',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [const PlayingCard(value: 1, bulls: 1)]),
        Player(
            id: 'p2',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [const PlayingCard(value: 10, bulls: 2)]),
        Player(
            id: 'p3',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [const PlayingCard(value: 55, bulls: 7)]),
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(
        effects,
        equals([
          GameEventGameOver(winner: const ['p1'])
        ]));
  });

  test('multiple winners if multiple players have the biggest number of bulls', () {
    // Given
    final state = Game(
      select: false,
      rows: [],
      players: [
        Player(
            id: 'p1',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [const PlayingCard(value: 3, bulls: 1)]),
        Player(
            id: 'p2',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [const PlayingCard(value: 9, bulls: 1)]),
        Player(
            id: 'p3',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [const PlayingCard(value: 15, bulls: 3)]),
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(
        effects,
        equals([
          GameEventGameOver(winner: const ['p1', 'p2'])
        ]));
  });
}
