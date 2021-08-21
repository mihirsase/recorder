abstract class ChatBubbleEvent {}

class PlayAudio extends ChatBubbleEvent {}

class PauseAudio extends ChatBubbleEvent {}

class ResumeAudio extends ChatBubbleEvent {}

class Reload extends ChatBubbleEvent {}

class StopWatchTick extends ChatBubbleEvent {
  final int value;

  StopWatchTick({required this.value,});
}

