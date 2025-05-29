// features/library/data/models/library_track_model.dart
import 'package:castor_exam/features/search/data/models/album_model.dart';
import 'package:castor_exam/features/search/data/models/artist_model.dart';
import 'package:castor_exam/features/search/domain/entities/track_entity.dart';

class LibraryTrackModel extends TrackEntity {
  final DateTime addedAt;

  LibraryTrackModel({
    required super.id,
    required super.name,
    super.previewUrl,
    required super.durationMs,
    required super.artists,
    super.album,
    required super.isPlayable,
    super.popularity,
    super.trackNumber,
    required this.addedAt,
  });

  factory LibraryTrackModel.fromJson(Map<String, dynamic> json) {
    return LibraryTrackModel(
      id: json['track']['id'],
      name: json['track']['name'],
      previewUrl: json['track']['preview_url'],
      durationMs: json['track']['duration_ms'],
      artists: (json['track']['artists'] as List)
          .map((artist) => ArtistModel.fromJson(artist))
          .toList(),
      album: json['track']['album'] != null
          ? AlbumModel.fromJson(json['track']['album'])
          : null,
      isPlayable: json['track']['is_playable'] ?? false,
      popularity: json['track']['popularity'],
      trackNumber: json['track']['track_number'],
      addedAt: DateTime.parse(json['added_at']),
    );
  }
}
