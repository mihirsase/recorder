import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recorder/blocs/home/home_event.dart';
import 'package:recorder/blocs/home/home_state.dart';
import 'package:recorder/models/audio.dart';
import 'package:recorder/services/sound_recoreder.dart';
import 'package:recorder/services/vibration_service.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SoundRecorder recorder = SoundRecorder();
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  FlutterSoundHelper flutterSoundHelper = FlutterSoundHelper();
  bool isRecording = false;
  List<Audio> audioList = [];

  HomeBloc() : super(HomeLoaded());

  @override
  Stream<HomeState> mapEventToState(
    final HomeEvent event,
  ) async* {
    if (event is StartRecording) {
      await VibrationService.instance.vibrate(100);
      recorder.record();
      isRecording = true;
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      stopWatchTimer.onExecute.add(StopWatchExecute.start);

      yield HomeLoaded();
    } else if (event is StopRecording) {
      if (isRecording) {
        String? audio = await recorder.stop();
        if (audio != null) {
          final AudioPlayer audioPlayer = AudioPlayer();
          final path = (await getTemporaryDirectory()).path;
          await audioPlayer.setFilePath(path + '/$audio');
          audioList.add(
            Audio(
              path: audio,
              createdAt: DateTime.now(),
              audioPlayer: audioPlayer,
            ),
          );
        }
        isRecording = false;
        stopWatchTimer.onExecute.add(StopWatchExecute.stop);

        yield HomeLoaded();
      }
    } else if (event is CancelRecording) {
      print('Recording cancelled');
      await recorder.stop();
      isRecording = false;
      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      VibrationService.instance.vibrate(150);

      yield HomeLoaded();
    }
  }
}
