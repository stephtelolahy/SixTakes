import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('next turn if all selected cards are put on rows', () {
    // Given
    final state = Game(
      select: false,
      rows: [],
      players: [
        Player(
            id: 'p1',
            name: '',
            photoURL: '',
            hand: [const PlayingCard(value: 44, bulls: 1)],
            gathered: [],
            bulls: 0,
            played: null),
        Player(
            id: 'p2',
            name: '',
            photoURL: '',
            hand: [const PlayingCard(value: 67, bulls: 1)],
            gathered: [],
            bulls: 0,
            played: null)
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(effects, equals([GameEventNextTurn()]));
  });
}
