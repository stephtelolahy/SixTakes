part of 'event.dart';

/// mark game as over
class GameEventGameOver extends GameEvent {
  final List<String> winner;

  GameEventGameOver({required this.winner});

  @override
  List<Object?> get props => [winner];

  @override
  dispatch(Game state) {
    state.winner = winner;
  }
}
