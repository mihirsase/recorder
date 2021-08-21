import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Audio {
  String path;
  Duration? duration;
  DateTime? createdAt;

  Audio({required this.path, this.createdAt, this.duration});

  String get formattedTime {
    if (createdAt != null) {
      return DateFormat('hh:mm a').format(DateTime.now());
    }
    return '';
  }

  String get formattedDuration {
    if (duration != null)
      return StopWatchTimer.getDisplayTime(
        duration!.inMilliseconds,
        hours: false,
        milliSecond: false,
      );
    return '';
  }
}
