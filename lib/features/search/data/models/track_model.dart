import 'package:castor_exam/core/utils/audio_fallback_provider.dart';
import 'package:castor_exam/features/search/data/models/artist_model.dart';
import 'package:castor_exam/features/search/data/models/album_model.dart';
import 'package:castor_exam/features/search/domain/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  TrackModel({
    required super.id,
    required super.name,
    super.previewUrl,
    required super.durationMs,
    required super.artists,
    super.album,
    required super.isPlayable,
    super.popularity,
    super.trackNumber,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'],
      name: json['name'],
      previewUrl:
          json['preview_url'] ?? AudioFallbackProvider.getRandomPreview(),
      durationMs: json['duration_ms'],
      artists: (json['artists'] as List)
          .map((artist) => ArtistModel.fromJson(artist))
          .toList(),
      album: json['album'] != null ? AlbumModel.fromJson(json['album']) : null,
      isPlayable: json['is_playable'] ?? false,
      popularity: json['popularity'],
      trackNumber: json['track_number'],
    );
  }

  @override
  String toString() {
    return 'TrackModel(id: $id, name: $name, previewUrl: $previewUrl, '
        'durationMs: $durationMs, artists: $artists, album: $album, '
        'isPlayable: $isPlayable, popularity: $popularity, '
        'trackNumber: $trackNumber)';
  }
}
