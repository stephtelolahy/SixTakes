import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('put smallest card on corresponding row', () {
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
            bulls: 0,
            played: const PlayingCard(value: 44, bulls: 1)),
        Player(
            id: 'p2',
            name: '',
            photoURL: '',
            hand: [],
            gathered: [],
            bulls: 0,
            played: const PlayingCard(value: 11, bulls: 1))
      ],
      rows: [
        GameRow(cards: [const PlayingCard(value: 88, bulls: 1)]),
        GameRow(cards: [const PlayingCard(value: 56, bulls: 1)]),
        GameRow(cards: [const PlayingCard(value: 35, bulls: 1)]),
        GameRow(cards: [const PlayingCard(value: 4, bulls: 1)])
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(effects, equals([GameEventPutRow(player: 'p2', row: 3)]));
  });

  test('gather row cards when no corresponding row', () {});

  test('gather row cards when putting sixth card', () {});
}
