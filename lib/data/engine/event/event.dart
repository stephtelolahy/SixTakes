import 'package:equatable/equatable.dart';
import 'package:sixtakes/data/model/game.dart';

part 'select_card.dart';
part 'uncover_cards.dart';
part 'put_row.dart';
part 'take_row.dart';
part 'next_turn.dart';
part 'game_over.dart';

// state update
abstract class GameEvent extends Equatable {
  dispatch(Game state);
}
