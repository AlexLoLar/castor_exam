// features/library/data/models/library_album_model.dart
import 'package:castor_exam/features/search/data/models/artist_model.dart';
import 'package:castor_exam/features/search/domain/entities/album_entity.dart';

class LibraryAlbumModel extends AlbumEntity {
  final DateTime addedAt;

  LibraryAlbumModel({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.artists,
    super.releaseDate,
    super.totalTracks,
    super.albumType,
    required this.addedAt,
  });

  factory LibraryAlbumModel.fromJson(Map<String, dynamic> json) {
    return LibraryAlbumModel(
      id: json['album']['id'],
      name: json['album']['name'],
      imageUrl:
          json['album']['images'] != null && json['album']['images'].isNotEmpty
              ? json['album']['images'][0]['url']
              : null,
      artists: (json['album']['artists'] as List)
          .map((artist) => ArtistModel.fromJson(artist))
          .toList(),
      releaseDate: json['album']['release_date'],
      totalTracks: json['album']['total_tracks'],
      albumType: json['album']['album_type'],
      addedAt: DateTime.parse(json['added_at']),
    );
  }
}
