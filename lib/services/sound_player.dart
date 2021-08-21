
import 'package:flutter_sound_lite/flutter_sound.dart';

class SoundPlayer {
  FlutterSoundPlayer? _myPlayer;
  bool _isInitialized = false;

  bool get isPlaying => _myPlayer!.isPlaying;
  bool get isPaused => _myPlayer!.isPaused;


  Future init() async {
    _myPlayer = FlutterSoundPlayer();
    await _myPlayer!.openAudioSession();
    _isInitialized = true;
  }

  void dispose() {
    if (!_isInitialized) return;
    _myPlayer!.closeAudioSession();
    _myPlayer = null;
    _isInitialized = false;
  }

  Future<Duration?> play(String audio, Function whenFinished) async {
    if (!_isInitialized) return null;
    Duration? d = await _myPlayer!.startPlayer(
      fromURI: audio,
      codec: Codec.mp3,
      whenFinished: () {
        whenFinished();
      },
    );
    return d;
  }

  void pause() async {
    if (!_isInitialized) return;
    await _myPlayer!.pausePlayer();
  }

  void resume() async {
    if (!_isInitialized) return;
    await _myPlayer!.resumePlayer();
  }
}
