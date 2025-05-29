import 'package:castor_exam/features/search/data/models/artist_model.dart';
import 'package:castor_exam/features/search/domain/entities/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.artists,
    super.releaseDate,
    super.totalTracks,
    super.albumType,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null,
      artists: (json['artists'] as List)
          .map((artist) => ArtistModel.fromJson(artist))
          .toList(),
      releaseDate: json['release_date'],
      totalTracks: json['total_tracks'],
      albumType: json['album_type'],
    );
  }

  @override
  String toString() {
    return 'AlbumModel(id: $id, name: $name, imageUrl: $imageUrl, '
        'artists: $artists, releaseDate: $releaseDate, '
        'totalTracks: $totalTracks, albumType: $albumType)';
  }
}
