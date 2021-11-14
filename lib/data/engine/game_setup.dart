import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/data/model/user.dart';

abstract class IGameSetup {
  Game createGame(List<User> users);
}

class GameSetup extends IGameSetup {
  @override
  Game createGame(List<User> users) {
    var deck = List.generate(104, (idx) => idx + 1);
    deck.shuffle();
    final players = users.map((e) {
      var hand = List.generate(10, (idx) => deck.removeAt(0));
      hand.sort((a, b) => a - b);
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
    return Game(select: true, board: board, players: players);
  }
}
