import 'artist_entity.dart';
import 'album_entity.dart';

class TrackEntity {
  final String id;
  final String name;
  final String? previewUrl;
  final int durationMs;
  final List<ArtistEntity> artists;
  final AlbumEntity? album;
  final bool isPlayable;
  final int? popularity;
  final int? trackNumber;

  TrackEntity({
    required this.id,
    required this.name,
    this.previewUrl,
    required this.durationMs,
    required this.artists,
    this.album,
    required this.isPlayable,
    this.popularity,
    this.trackNumber,
  });
}
