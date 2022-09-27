import 'package:audioplayers/audioplayers.dart';

class AudioPlayerRepository {
  final player = AudioPlayer();

  Future<void> play(String url) {
    return player.play(UrlSource(url));
  }

  Future<void> stop() => player.stop();

  Stream<PlayerState> get onStateChanged => player.onPlayerStateChanged;
}
