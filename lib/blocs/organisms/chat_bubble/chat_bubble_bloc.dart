import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_event.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_state.dart';
import 'package:recorder/models/audio.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChatBubbleBloc extends Bloc<ChatBubbleEvent, ChatBubbleState> {

  final Audio audio;
  int position = 0;
  String formattedDuration = '';

  ChatBubbleBloc({
    required this.audio,
  }) : super(ChatBubbleLoaded());

  @override
  Stream<ChatBubbleState> mapEventToState(
    final ChatBubbleEvent event,
  ) async* {
    if (event is PlayAudio) {

      audio.audioPlayer!.play();
      yield ChatBubbleLoaded();
    } else if (event is PauseAudio) {
      audio.audioPlayer!.pause();
      yield ChatBubbleLoaded();
    } else if (event is ResumeAudio) {
      audio.audioPlayer!.play();
      yield ChatBubbleLoaded();
    } else if (event is Tick) {
      formattedDuration = StopWatchTimer.getDisplayTime(
        event.position.inMilliseconds,
        hours: false,
        milliSecond: false,
      );
      position = event.position.inMilliseconds;
      yield ChatBubbleLoaded();
    } else if (event is Reload) {
      position = 0;
      audio.audioPlayer!.stop();
      yield ChatBubbleLoaded();
    }
  }
}
