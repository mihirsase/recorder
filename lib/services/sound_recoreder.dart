import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isInitialized = false;

  bool get isRecording => _audioRecorder!.isRecording;
  int _audioCnt = 0;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _audioRecorder!.openAudioSession();
    _isInitialized = true;
  }

  void dispose() {
    if (!_isInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isInitialized = false;
  }

  Future record() async {
    if (!_isInitialized) return;

    await _audioRecorder!.startRecorder(toFile: 'audio$_audioCnt.aac');
  }

  Future<String?> stop() async {
    if (!_isInitialized) return null;

    await _audioRecorder!.stopRecorder();
    String audio = 'audio$_audioCnt.aac';
    _audioCnt++;
    return audio;
  }
}
