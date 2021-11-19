import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/engine/event/event.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/game.dart';

void main() {
  final sut = GameRules();

  test('single winner if one player has the biggest number of bulls', () {
    // Given
    final state = Game(
      select: false,
      rows: [],
      players: [
        Player(id: 'p1', name: '', photoURL: '', hand: [], gathered: [], bulls: 10),
        Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [], bulls: 20),
        Player(id: 'p3', name: '', photoURL: '', hand: [], gathered: [], bulls: 30),
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(
        effects,
        equals([
          GameEventGameOver(winner: const ['p1'])
        ]));
  });

  test('multiple winners if multiple players have the biggest number of bulls', () {
    // Given
    final state = Game(
      select: false,
      rows: [],
      players: [
        Player(id: 'p1', name: '', photoURL: '', hand: [], gathered: [], bulls: 10),
        Player(id: 'p2', name: '', photoURL: '', hand: [], gathered: [], bulls: 10),
        Player(id: 'p3', name: '', photoURL: '', hand: [], gathered: [], bulls: 30),
      ],
    );

    // When
    final effects = sut.triggered(state);

    // Assert
    expect(
        effects,
        equals([
          GameEventGameOver(winner: const ['p1', 'p2'])
        ]));
  });
}
