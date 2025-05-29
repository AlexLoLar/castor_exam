import 'artist_entity.dart';
import 'track_entity.dart';
import 'album_entity.dart';

class SearchResultEntity {
  final List<TrackEntity> tracks;
  final List<ArtistEntity> artists;
  final List<AlbumEntity> albums;

  SearchResultEntity({
    required this.tracks,
    required this.artists,
    required this.albums,
  });
}
