import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/data/model/user.dart';

abstract class IGameSetup {
  Game createGame(List<User> users, List<PlayingCard> deck);
}

class GameSetup extends IGameSetup {
  @override
  Game createGame(List<User> users, List<PlayingCard> deck) {
    deck.shuffle();
    final players = users.map((e) {
      var hand = List.generate(10, (idx) => deck.removeAt(0));
      hand.sort((a, b) => a.value - b.value);
      return Player(
        id: e.id,
        name: e.name,
        photoURL: e.photoURL,
        hand: hand,
        gathered: [],
        bulls: 0,
      );
    }).toList();
    final board = List.generate(4, (idx) => GameRow(cards: [deck.removeAt(0)]));
    return Game(select: true, rows: board, players: players);
  }
}
