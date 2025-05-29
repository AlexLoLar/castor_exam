import 'package:audioplayers/audioplayers.dart';

class AudioPlayerManager {
  final AudioPlayer _player = AudioPlayer();

  Stream<Duration> get positionStream => _player.onPositionChanged;
  Stream<Duration> get durationStream => _player.onDurationChanged;

  Future<void> play(String source, {bool isAsset = false}) async {
    await _player.stop();
    if (isAsset) {
      await _player.play(AssetSource(source));
    } else {
      await _player.play(UrlSource(source));
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.resume();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void dispose() {
    _player.dispose();
  }
}
