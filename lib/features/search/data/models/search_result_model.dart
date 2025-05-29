import 'package:castor_exam/features/search/data/models/album_model.dart';
import 'package:castor_exam/features/search/data/models/artist_model.dart';
import 'package:castor_exam/features/search/data/models/track_model.dart';
import 'package:castor_exam/features/search/domain/entities/search_result_entity.dart';

class SearchResultModel extends SearchResultEntity {
  SearchResultModel({
    required super.tracks,
    required super.artists,
    required super.albums,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      tracks: (json['tracks']?['items'] as List? ?? [])
          .map((track) => TrackModel.fromJson(track))
          .toList(),
      artists: (json['artists']?['items'] as List? ?? [])
          .map((artist) => ArtistModel.fromJson(artist))
          .toList(),
      albums: (json['albums']?['items'] as List? ?? [])
          .map((album) => AlbumModel.fromJson(album))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'SearchResultModel(\n'
        '  Tracks: $tracks,\n'
        '  Artists: $artists,\n'
        '  Albums: $albums\n'
        ')';
  }
}
