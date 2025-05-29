class ArtistEntity {
  final String id;
  final String name;
  final String? imageUrl;
  final int? followers;
  final List<String>? genres;
  final int? popularity;

  ArtistEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    this.followers,
    this.genres,
    this.popularity,
  });
}
