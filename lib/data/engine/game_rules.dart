import 'package:sixtakes/data/model/game.dart';

abstract class IGameRules {
  // Return bulls for a given card value
  int bullsForCard(int value);

  // Return winner id if game is over
  String? isGameOver(Game game);
}

class GameRules extends IGameRules {
  @override
  int bullsForCard(int value) {
    if (value % 11 == 0) {
      if (value == 55) {
        return 7;
      }
      return 5;
    }

    if (value % 5 == 0) {
      if (value % 10 == 0) {
        return 3;
      }
      return 2;
    }

    return 1;
  }

  @override
  String? isGameOver(Game game) {
    return null;
  }
}
