import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('set select phase if dispatching next turn', () {
    // Given
    final state = Game(select: false, rows: [], players: []);
    final event = GameEventNextTurn();

    // When
    event.dispatch(state);

    // Assert
    expect(state.select, isTrue);
  });
}
