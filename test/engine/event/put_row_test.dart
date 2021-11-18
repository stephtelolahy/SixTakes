import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('put played card in a row', () {
    // Given
    final state = Game(select: true, rows: [
      GameRow(cards: [43, 49]),
      GameRow(cards: [99, 104]),
    ], players: [
      Player(id: 'p1', name: '', photoURL: '', hand: [], played: 55, gathered: [], bulls: 0)
    ]);
    final event = GameEventPutRow(player: 'p1', row: 0, card: 55);

    // When
    event.dispatch(state);

    // Assert
    final actor = state.players.firstWhere((e) => e.id == 'p1');

    expect(actor.played, isNull);
    expect(state.rows[0].cards, equals([43, 49, 55]));
    expect(state.rows[1].cards, equals([99, 104]));
  });
}
