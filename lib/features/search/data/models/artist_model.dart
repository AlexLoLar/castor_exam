import 'package:castor_exam/features/search/domain/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  ArtistModel({
    required super.id,
    required super.name,
    super.imageUrl,
    super.followers,
    super.genres,
    super.popularity,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['url']
          : null,
      followers: json['followers']?['total'],
      genres: (json['genres'] as List?)?.cast<String>(),
      popularity: json['popularity'],
    );
  }

  @override
  String toString() {
    return 'ArtistModel(id: $id, name: $name, imageUrl: $imageUrl, '
        'followers: $followers, genres: $genres, popularity: $popularity)';
  }
}
