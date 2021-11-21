import 'package:sixtakes/data/engine/deck.dart';
import 'package:sixtakes/data/engine/setup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/user.dart';

void main() {
  final sut = GameSetup();

  test('setup game with 2 players', () {
    // Given
    const user1 = User(id: '1', name: 'name1', photoURL: 'photo1', score: 0);
    const user2 = User(id: '2', name: 'name2', photoURL: 'photo2', score: 0);
    final deck = GameDeck().createDeck();

    // When
    final state = sut.createGame([user1, user2], deck);

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
      expect(player.gathered, isEmpty);
      expect(player.hand.length, equals(10), reason: 'each player should have 10 cards');
      expect(player.hand.isSorted(), isTrue, reason: 'hand must be sorted');
    }

    expect(state.rows.length, equals(4));
    for (var row in state.rows) {
      expect(row.cards.length, equals(1), reason: 'each row must contain one card');
    }

    expect(state.select, isTrue);
    expect(state.winner, isNull);
  });
}

extension IsSorted on List<PlayingCard> {
  bool isSorted() {
    PlayingCard? previous;
    for (var card in this) {
      if (previous != null && card.value < previous.value) {
        return false;
      }
      previous = card;
    }
    return true;
  }
}
