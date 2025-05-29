import 'artist_entity.dart';

class AlbumEntity {
  final String id;
  final String name;
  final String? imageUrl;
  final List<ArtistEntity> artists;
  final String? releaseDate;
  final int? totalTracks;
  final String? albumType;

  AlbumEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.artists,
    this.releaseDate,
    this.totalTracks,
    this.albumType,
  });
}
