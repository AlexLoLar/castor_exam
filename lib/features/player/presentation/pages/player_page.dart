import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/player_bloc.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        if (state is PlayerPlaying) {
          return Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          state.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          if (state.isPlaying) {
                            context.read<PlayerBloc>().add(PauseTrackEvent());
                          } else {
                            context.read<PlayerBloc>().add(ResumeTrackEvent());
                          }
                        },
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.track.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            StreamBuilder<Duration>(
                              stream: context.read<PlayerBloc>().durationStream,
                              builder: (context, snapshot) {
                                final duration = snapshot.data ?? Duration.zero;
                                return StreamBuilder<Duration>(
                                  stream:
                                      context.read<PlayerBloc>().positionStream,
                                  builder: (context, snapshot) {
                                    var position =
                                        snapshot.data ?? Duration.zero;
                                    if (position > duration) {
                                      position = duration;
                                    }

                                    return Column(
                                      children: [
                                        Slider(
                                          min: 0,
                                          max: duration.inMilliseconds
                                              .toDouble(),
                                          value: position.inMilliseconds
                                              .toDouble(),
                                          onChanged: (value) {
                                            context.read<PlayerBloc>().add(
                                                  SeekTrackEvent(
                                                    Duration(
                                                        milliseconds:
                                                            value.toInt()),
                                                  ),
                                                );
                                          },
                                          activeColor: Colors.deepPurple,
                                          inactiveColor: Colors.grey[300],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _formatDuration(position),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                _formatDuration(duration),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          context.read<PlayerBloc>().add(StopTrackEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
