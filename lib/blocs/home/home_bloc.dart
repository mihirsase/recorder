import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:recorder/blocs/home/home_event.dart';
import 'package:recorder/blocs/home/home_state.dart';
import 'package:recorder/models/audio.dart';
import 'package:recorder/services/sound_player.dart';
import 'package:recorder/services/sound_recoreder.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SoundRecorder recorder = SoundRecorder();
  SoundPlayer player = SoundPlayer();
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
      recorder.record();
      isRecording = true;
      stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      stopWatchTimer.onExecute.add(StopWatchExecute.start);

      yield HomeLoaded();
    } else if (event is StopRecording) {
      String? audio = await recorder.stop();
      if (audio != null) {
        audioList.add(Audio(
          path: audio,
          createdAt: DateTime.now(),
        ));
      }
      isRecording = false;
      stopWatchTimer.onExecute.add(StopWatchExecute.stop);

      yield HomeLoaded();
    }
  }
}
