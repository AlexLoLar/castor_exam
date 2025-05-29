import 'package:castor_exam/features/player/data/datasources/local/audio_player_manager.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/playing_track.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioPlayerManager _service;
  late final Stream<Duration> positionStream;
  late final Stream<Duration> durationStream;

  PlayerBloc(this._service) : super(PlayerInitial()) {
    positionStream = _service.positionStream;
    durationStream = _service.durationStream;

    on<PlayTrackEvent>((event, emit) async {
      try {
        await _service.play(event.track.source, isAsset: event.track.isAsset);
        emit(PlayerPlaying(event.track, isPlaying: true));
      } catch (e) {
        emit(PlayerError("No se pudo reproducir el audio: ${e.toString()}"));
      }
    });

    on<PauseTrackEvent>((event, emit) async {
      if (state is PlayerPlaying) {
        await _service.pause();
        emit((state as PlayerPlaying).copyWith(isPlaying: false));
      }
    });

    on<ResumeTrackEvent>((event, emit) async {
      if (state is PlayerPlaying) {
        await _service.resume();
        emit((state as PlayerPlaying).copyWith(isPlaying: true));
      }
    });

    on<StopTrackEvent>((event, emit) async {
      await _service.stop();
      emit(PlayerStopped());
    });

    on<SeekTrackEvent>((event, emit) async {
      if (state is PlayerPlaying) {
        await _service.seek(event.position);
      }
    });
  }

  @override
  Future<void> close() {
    _service.dispose();
    return super.close();
  }
}
