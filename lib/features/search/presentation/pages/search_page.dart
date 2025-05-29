import 'package:castor_exam/core/presentation/widgets/album_card.dart';
import 'package:castor_exam/core/presentation/widgets/artist_card.dart';
import 'package:castor_exam/features/favorites/presentation/pages/favorite_button.dart';
import 'package:castor_exam/features/player/domain/entities/playing_track.dart';
import 'package:castor_exam/features/player/presentation/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:castor_exam/features/search/presentation/bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return Center(child: Text('Error: ${state.failure.message}'));
          } else if (state is SearchLoaded) {
            return BlocListener<PlayerBloc, PlayerState>(
              listener: (context, playerState) {
                if (playerState is PlayerError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(playerState.message)),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.results.tracks.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Canciones',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.results.tracks.length,
                        itemBuilder: (context, index) {
                          final track = state.results.tracks[index];
                          final playerState = context.watch<PlayerBloc>().state;

                          final isPlaying = playerState is PlayerPlaying &&
                              playerState.track.name == track.name;

                          return ListTile(
                            onTap: () {
                              final hasPreview = track.previewUrl != null;
                              final source = hasPreview
                                  ? track.previewUrl!
                                  : 'audio/sound${(index % 5) + 1}.mp3';

                              final trackToPlay = PlayingTrack(
                                name: track.name,
                                source: source,
                                isAsset: hasPreview,
                              );

                              context
                                  .read<PlayerBloc>()
                                  .add(PlayTrackEvent(trackToPlay));
                            },
                            leading: track.album?.imageUrl != null
                                ? Image.network(track.album!.imageUrl!)
                                : const Icon(Icons.music_note),
                            title: Text(track.name),
                            subtitle: Text(
                                track.artists.map((a) => a.name).join(', ')),
                            trailing: SizedBox(
                              width: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    isPlaying
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_fill,
                                    color: Colors.deepPurple,
                                  ),
                                  FavoriteButton(id: track.id),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    if (state.results.artists.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Artistas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.results.artists.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Número de columnas
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio:
                              3 / 4, // Ajusta según el diseño del card
                        ),
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final artist = state.results.artists[index];
                          return ArtistCard(
                            name: artist.name,
                            imageUrl: artist.imageUrl,
                            onTap: () {
                              // Opcional: navegar a detalle del artista
                            },
                          );
                        },
                      )
                    ],
                    if (state.results.albums.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Álbumes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 225,
                        padding: EdgeInsets.symmetric(horizontal: 11),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.results.albums.length,
                          itemBuilder: (context, index) {
                            final album = state.results.albums[index];
                            return AlbumCard(
                              name: album.name,
                              artist:
                                  album.artists.map((a) => a.name).join(', '),
                              imageUrl: album.imageUrl,
                              onTap: () {
                                // Acción al tocar el álbum
                              },
                              id: album.id,
                            );
                          },
                        ),
                      ),
                    ],
                    if (state.results.tracks.isEmpty &&
                        state.results.artists.isEmpty &&
                        state.results.albums.isEmpty)
                      const Center(child: Text('No se encontraron resultados')),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: Text('Busca artistas, canciones o álbumes'));
          }
        },
      ),
    );
  }
}
