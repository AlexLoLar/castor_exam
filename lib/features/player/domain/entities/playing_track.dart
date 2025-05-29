class PlayingTrack {
  final String name;
  final String source;
  final bool isAsset;

  PlayingTrack({
    required this.name,
    required this.source,
    this.isAsset = false,
  });
}
