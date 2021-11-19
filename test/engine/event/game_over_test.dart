import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('set winner if dispatching game over', () {
    // Given
    final state = Game(select: false, rows: [], players: [], winner: null);
    final event = GameEventGameOver(winner: const ['p1']);

    // When
    event.dispatch(state);

    // Assert
    expect(state.winner, equals(['p1']));
  });
}
