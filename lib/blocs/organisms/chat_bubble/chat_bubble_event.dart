abstract class ChatBubbleEvent {}

class PlayAudio extends ChatBubbleEvent {}

class PauseAudio extends ChatBubbleEvent {}

class ResumeAudio extends ChatBubbleEvent {}

class Reload extends ChatBubbleEvent {}

class Tick extends ChatBubbleEvent {
  final Duration position;

  Tick({
    required this.position,
  });
}
