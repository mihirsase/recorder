import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_event.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_state.dart';
import 'package:recorder/models/audio.dart';
import 'package:recorder/services/sound_player.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChatBubbleBloc extends Bloc<ChatBubbleEvent, ChatBubbleState> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );
  final Audio audio;
  final SoundPlayer player;
  int position = 0;
  int duration = 0;
  String formattedDuration = '';

  ChatBubbleBloc({
    required this.audio,
    required this.player,
  }) : super(ChatBubbleLoaded());

  @override
  Stream<ChatBubbleState> mapEventToState(
    final ChatBubbleEvent event,
  ) async* {
    if (event is PlayAudio) {
      Duration? d = await player.play(audio.path, () {
        stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        position = 0;
        this.add(Reload());
      });
      position = 0;
      duration = d!.inMilliseconds;
      stopWatchTimer.setPresetSecondTime(d.inSeconds);
      stopWatchTimer.onExecute.add(StopWatchExecute.start);
      yield ChatBubbleLoaded();
    } else if (event is PauseAudio) {
      player.pause();
      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      yield ChatBubbleLoaded();
    } else if (event is ResumeAudio) {
      player.resume();
      stopWatchTimer.onExecute.add(StopWatchExecute.start);
      yield ChatBubbleLoaded();
    } else if (event is StopWatchTick) {
      position = (duration - event.value).isNegative ? 0 : duration - event.value;
      formattedDuration = StopWatchTimer.getDisplayTime(
        event.value,
        hours: false,
        milliSecond: false,
      );
      yield ChatBubbleLoaded();
    } else if (event is Reload) {
      yield ChatBubbleLoaded();
    }
  }
}
