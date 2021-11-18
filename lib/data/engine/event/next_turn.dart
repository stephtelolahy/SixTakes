part of 'event.dart';

/// mark each player must select a card
class GameEventNextTurn extends GameEvent {
  @override
  List<Object?> get props => [];

  @override
  dispatch(Game state) {
    state.select = true;
  }
}
