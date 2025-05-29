part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class PlayTrackEvent extends PlayerEvent {
  final PlayingTrack track;

  const PlayTrackEvent(this.track);

  @override
  List<Object> get props => [track];
}

class PauseTrackEvent extends PlayerEvent {}

class ResumeTrackEvent extends PlayerEvent {}

class StopTrackEvent extends PlayerEvent {}

class SeekTrackEvent extends PlayerEvent {
  final Duration position;

  const SeekTrackEvent(this.position);

  @override
  List<Object> get props => [position];
}
