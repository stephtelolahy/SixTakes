import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('gather row cards when no corresponding row', () {
    // Given
    final state = Game(
      select: false,
      players: [
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
      ],
      rows: [
        GameRow(cards: [const PlayingCard(value: 80, bulls: 3)]),
        GameRow(cards: [const PlayingCard(value: 55, bulls: 7)]),
        GameRow(cards: [const PlayingCard(value: 34, bulls: 1)]),
        GameRow(cards: [const PlayingCard(value: 15, bulls: 2)])
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(
        effects,
        equals([
          GameEventTakeRow(player: 'p2', row: 2),
          GameEventPutRow(player: 'p2', row: 2),
        ]));
  });

  test('gather row cards when putting sixth card', () {
    // Given
    final state = Game(
      select: false,
      players: [
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
      ],
      rows: [
        GameRow(cards: [const PlayingCard(value: 80, bulls: 3)]),
        GameRow(cards: [const PlayingCard(value: 55, bulls: 7)]),
        GameRow(cards: [const PlayingCard(value: 34, bulls: 1)]),
        GameRow(cards: [
          const PlayingCard(value: 2, bulls: 1),
          const PlayingCard(value: 5, bulls: 3),
          const PlayingCard(value: 6, bulls: 1),
          const PlayingCard(value: 9, bulls: 1),
          const PlayingCard(value: 10, bulls: 2)
        ])
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(
        effects,
        equals([
          GameEventTakeRow(player: 'p2', row: 3),
          GameEventPutRow(player: 'p2', row: 3),
        ]));
  });
}
