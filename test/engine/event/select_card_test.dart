import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('put the card face down on the table if dispatching select a card', () {
    // Given
    final state = Game(select: true, rows: [], players: [
      Player(
        id: 'p1',
        name: '',
        photoURL: '',
        hand: [
          const PlayingCard(value: 2, bulls: 1),
          const PlayingCard(value: 30, bulls: 3),
        ],
        gathered: [],
      ),
      Player(
          id: 'p2',
          name: '',
          photoURL: '',
          hand: [],
          gathered: [],
          played: const PlayingCard(value: 11, bulls: 1))
    ]);
    final event = GameEventSelectCard(player: 'p1', card: 2);

    // When
    event.dispatch(state);

    // Assert
    final actor = state.players.firstWhere((e) => e.id == 'p1');
    expect(actor.played?.value, equals(2));
    expect(actor.hand.map((e) => e.value), equals([30]));
  });
}
