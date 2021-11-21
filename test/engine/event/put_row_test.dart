import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('put played card in a row', () {
    // Given
    final state = Game(select: true, rows: [
      GameRow(cards: [
        const PlayingCard(value: 43, bulls: 1),
        const PlayingCard(value: 50, bulls: 3),
      ]),
      GameRow(cards: [
        const PlayingCard(value: 99, bulls: 1),
        const PlayingCard(value: 104, bulls: 1),
      ]),
    ], players: [
      Player(
        id: 'p1',
        name: '',
        photoURL: '',
        hand: [],
        played: const PlayingCard(value: 55, bulls: 7),
        gathered: [],
      )
    ]);
    final event = GameEventPutRow(player: 'p1', row: 0);

    // When
    event.dispatch(state);

    // Assert
    final actor = state.players.firstWhere((e) => e.id == 'p1');
    final row = state.rows[0];
    expect(actor.played, isNull);
    expect(row.cards.map((e) => e.value), equals([43, 50, 55]));
  });
}
