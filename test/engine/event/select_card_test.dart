import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('select a card', () {
    // Given
    final state = Game(select: true, board: [], players: [
      Player(id: 'p1', name: '', photoURL: '', hand: [1, 2, 3], gathered: [], bulls: 0),
      Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [], bulls: 0, played: 11)
    ]);
    final event = GameEventSelectCard(player: 'p1', card: 2);

    // When
    event.dispatch(state);

    // Assert
    final you = state.players.firstWhere((e) => e.id == 'p1');
    expect(you.played, equals(2));
    expect(you.hand, equals([1, 3]));
  });
}
