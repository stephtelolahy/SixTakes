import 'package:sixtakes/data/engine/game_setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/model/user.dart';

void main() {
  final sut = GameSetup();

  test('setup game with 2 players', () {
    // Given
    final user1 = User('1', 'name1', 'photo1', 0);
    final user2 = User('2', 'name2', 'photo2', 0);

    // When
    final state = sut.createGame([user1, user2]);

    // Assert
    expect(state.players.length, equals(2));
    expect(state.players[0].id, equals('1'));
    expect(state.players[0].name, equals('name1'));
    expect(state.players[0].photoURL, equals('photo1'));
    expect(state.players[1].id, equals('2'));
    expect(state.players[1].name, equals('name2'));
    expect(state.players[1].photoURL, equals('photo2'));
    for (var player in state.players) {
      expect(player.played, isNull);
      expect(player.bulls, equals(0));
      expect(player.hand.length, equals(10), reason: 'each player should have 10 cards');
      expect(player.hand.isSorted(), isTrue, reason: 'hand must be sorted');
    }

    expect(state.board.length, equals(4));
    for (var row in state.board) {
      expect(row.cards.length, equals(1), reason: 'each row must contain one card');
    }

    expect(state.phase, equals(0));
    expect(state.winner, isNull);
  });
}

extension IsSorted on List<int> {
  bool isSorted() {
    int previous = 0;
    for (var value in this) {
      if (value < previous) {
        return false;
      } else {
        previous = value;
      }
    }
    return true;
  }
}