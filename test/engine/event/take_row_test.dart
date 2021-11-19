import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('take all cards in a row', () {
    // Given
    final state = Game(select: true, rows: [
      GameRow(cards: [93, 102]),
      GameRow(cards: [4, 11, 19, 20, 34]),
    ], players: [
      Player(
          id: 'p1',
          name: '',
          photoURL: '',
          hand: [],
          played: 55,
          gathered: [6, 9, 12, 44],
          bulls: 7)
    ]);
    final event = GameEventTakeRow(player: 'p1', row: 1);

    // When
    event.dispatch(state);

    // Assert
    final actor = state.players.firstWhere((e) => e.id == 'p1');
    expect(actor.played, equals([55]));
    expect(actor.gathered, equals([6, 9, 12, 44, 4, 11, 19, 20, 34]));
    expect(state.rows[0].cards, equals([93, 102]));
    expect(state.rows[1].cards, isEmpty);
  });
}
