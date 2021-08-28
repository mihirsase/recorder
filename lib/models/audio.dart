import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Audio {
  String path;
  DateTime? createdAt;
  AudioPlayer? audioPlayer;

  Audio({
    required this.path,
    this.createdAt,
    this.audioPlayer,
  });

  String get formattedTime {
    if (createdAt != null) {
      return DateFormat('hh:mm a').format(createdAt!);
    }
    return '';
  }

  String get formattedDuration {
    if (audioPlayer != null && audioPlayer!.duration !=null)
      return StopWatchTimer.getDisplayTime(
        audioPlayer!.duration!.inMilliseconds,
        hours: false,
        milliSecond: false,
      );
    return '';
  }
}
