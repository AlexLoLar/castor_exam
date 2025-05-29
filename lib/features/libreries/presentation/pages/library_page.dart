// features/library/presentation/pages/library_page.dart
import 'package:castor_exam/features/libreries/presentation/bloc/library_bloc.dart';
import 'package:castor_exam/features/player/domain/entities/playing_track.dart';
import 'package:castor_exam/features/player/presentation/bloc/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late LibraryBloc _libraryBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _libraryBloc = context.read<LibraryBloc>();
      _libraryBloc.add(LoadTracksEvent());
    });
    print('afadf');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            if (index == 0) {
              _libraryBloc.add(LoadTracksEvent());
            } else {
              _libraryBloc.add(LoadAlbumsEvent());
            }
          },
          tabs: const [
            Tab(text: 'Canciones'),
            Tab(text: 'Álbumes'),
          ],
          indicatorColor: Colors.deepPurple,
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: [
              // Pestaña de canciones
              _buildTracksTab(state),
              // Pestaña de álbumes
              _buildAlbumsTab(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTracksTab(LibraryState state) {
    if (state is TracksLoaded) {
      return BlocListener<PlayerBloc, PlayerState>(
        listener: (context, playerState) {
          if (playerState is PlayerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(playerState.message)),
            );
          }
        },
        child: ListView.builder(
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            final track = state.tracks[index];
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
                  isAsset: !hasPreview,
                );

                print('${isPlaying} $trackToPlay');

                context.read<PlayerBloc>().add(PlayTrackEvent(trackToPlay));
              },
              leading: track.album?.imageUrl != null
                  ? Image.network(track.album!.imageUrl!)
                  : const Icon(Icons.music_note),
              title: Text(track.name),
              subtitle: Text(track.artists.map((a) => a.name).join(', ')),
              trailing: SizedBox(
                width: 40,
                child: Row(
                  children: [
                    Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else if (state is LibraryError) {
      return Center(child: Text('Error: ${state.failure.message}'));
    } else if (state is LibraryLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(child: Text('No hay canciones guardadas'));
    }
  }

  Widget _buildAlbumsTab(LibraryState state) {
    if (state is AlbumsLoaded) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: state.albums.length,
        itemBuilder: (context, index) {
          final album = state.albums[index];
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: album.imageUrl != null
                      ? Image.network(
                          album.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const Icon(Icons.album, size: 100),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    album.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  album.artists.map((a) => a.name).join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      );
    } else if (state is LibraryError) {
      return Center(child: Text('Error: ${state.failure.message}'));
    } else if (state is LibraryLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Center(child: Text('No hay álbumes guardados'));
    }
  }
}
