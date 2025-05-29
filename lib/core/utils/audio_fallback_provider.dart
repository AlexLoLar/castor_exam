class AudioFallbackProvider {
  static final List<String> fallbackPreviews = [
    'audio/sound1.mp3',
    'audio/sound2.mp3',
    'audio/sound3.mp3',
    'audio/sound4.mp3',
    'audio/sound5.mp3',
  ];

  static String getRandomPreview() {
    fallbackPreviews.shuffle();
    return fallbackPreviews.first;
  }
}
