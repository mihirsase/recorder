import 'package:flutter_sound_lite/flutter_sound.dart';

class SoundPlayer {
  FlutterSoundPlayer? _myPlayer;
  bool _isInitialized = false;

  bool get isPlaying => _myPlayer!.isPlaying;

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

  void play(String audio) async {
    if (!_isInitialized) return;
    await _myPlayer!.startPlayer(
      fromURI: audio,
      codec: Codec.mp3,
      whenFinished: () {
        print('Done');
      },
    );
  }

  void pause() async {
    if (!_isInitialized) return;
  }
}
