import 'package:sixtakes/data/model/card.dart';

abstract class IGameDeck {
  List<PlayingCard> createDeck();
}

class GameDeck extends IGameDeck {
  static const int cardsCount = 104;

  @override
  List<PlayingCard> createDeck() {
    return List.generate(cardsCount, (idx) {
      final value = idx + 1;
      final bulls = _bullsForCard(value);
      return PlayingCard(value: value, bulls: bulls);
    });
  }

  int _bullsForCard(int value) {
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
}
