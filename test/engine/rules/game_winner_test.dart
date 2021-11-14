import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/game_rules.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('no winner if any player still have card', () {
    // Given
    final state = Game(select: false, board: [], players: [
      Player(id: 'p1', name: '', photoURL: '', hand: [], gathered: [], played: 34, bulls: 10),
      Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [], bulls: 20),
      Player(id: 'p3', name: '', photoURL: '', hand: [], gathered: [], bulls: 30),
    ]);

    // When
    final winners = sut.winners(state);

    // Assert
    expect(winners, isNull);
  });

  test('single winner', () {
    // Given
    final state = Game(select: false, board: [], players: [
      Player(id: 'p1', name: '', photoURL: '', hand: [], gathered: [], bulls: 10),
      Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [], bulls: 20),
      Player(id: 'p3', name: '', photoURL: '', hand: [], gathered: [], bulls: 30),
    ]);

    // When
    final winners = sut.winners(state);

    // Assert
    expect(winners, equals(['p1']));
  });

  test('multiple winners', () {
    // Given
    final state = Game(select: false, board: [], players: [
      Player(id: 'p1', name: '', photoURL: '', hand: [], gathered: [], bulls: 10),
      Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [], bulls: 10),
      Player(id: 'p3', name: '', photoURL: '', hand: [], gathered: [], bulls: 30),
    ]);

    // When
    final winners = sut.winners(state);

    // Assert
    expect(winners, equals(['p1', 'p2']));
  });
}
