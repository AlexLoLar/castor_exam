part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerPlaying extends PlayerState {
  final PlayingTrack track;
  final bool isPlaying;

  const PlayerPlaying(this.track, {required this.isPlaying});

  PlayerPlaying copyWith({bool? isPlaying}) {
    return PlayerPlaying(
      track,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [track, isPlaying];
}

class PlayerStopped extends PlayerState {}

class PlayerError extends PlayerState {
  final String message;

  const PlayerError(this.message);

  @override
  List<Object> get props => [message];
}
