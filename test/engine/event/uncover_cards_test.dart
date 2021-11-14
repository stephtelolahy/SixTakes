import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('uncover cards', () {
    // Given
    final state = Game(select: true, board: [], players: []);
    final event = GameEventUncoverCards();

    // When
    event.dispatch(state);

    // Assert
    expect(state.select, equals(false));
  });
}
