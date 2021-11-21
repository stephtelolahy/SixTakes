import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  test('take all cards in a row', () {
    // Given
    final state = Game(select: true, rows: [
      GameRow(cards: [
        const PlayingCard(value: 95, bulls: 2),
        const PlayingCard(value: 102, bulls: 1),
      ]),
      GameRow(cards: [
        const PlayingCard(value: 11, bulls: 1),
        const PlayingCard(value: 19, bulls: 1),
      ]),
    ], players: [
      Player(
        id: 'p1',
        name: '',
        photoURL: '',
        hand: [],
        gathered: [],
      )
    ]);
    final event = GameEventTakeRow(player: 'p1', row: 1);

    // When
    event.dispatch(state);

    // Assert
    final actor = state.players.firstWhere((e) => e.id == 'p1');
    expect(actor.gathered.map((e) => e.value), equals([11, 19]));
    expect(state.rows[1].cards, isEmpty);
  });

  test('take cards in a row excluding some card', () {
    // Given
    final state = Game(select: true, rows: [
      GameRow(cards: [
        const PlayingCard(value: 95, bulls: 2),
        const PlayingCard(value: 102, bulls: 1),
      ]),
      GameRow(cards: [
        const PlayingCard(value: 5, bulls: 2),
        const PlayingCard(value: 11, bulls: 1),
        const PlayingCard(value: 19, bulls: 1),
        const PlayingCard(value: 20, bulls: 3),
        const PlayingCard(value: 34, bulls: 1),
        const PlayingCard(value: 55, bulls: 7),
      ]),
    ], players: [
      Player(
        id: 'p1',
        name: '',
        photoURL: '',
        hand: [],
        gathered: [],
      )
    ]);
    final event = GameEventTakeRow(player: 'p1', row: 1, excluding: 55);

    // When
    event.dispatch(state);

    // Assert
    final actor = state.players.firstWhere((e) => e.id == 'p1');
    expect(actor.gathered.map((e) => e.value), equals([5, 11, 19, 20, 34]));
    expect(state.rows[1].cards.map((e) => e.value), equals([55]));
  });
}
