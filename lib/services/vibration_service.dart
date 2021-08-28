import 'package:vibration/vibration.dart';

class VibrationService {
  static final VibrationService instance = VibrationService._();

  VibrationService._();

  Future vibrate(int duration) async {
    bool? canVibrate = await Vibration.hasVibrator();
    if (canVibrate != null && canVibrate) {
     await Vibration.vibrate(duration: duration,);
    }
  }
}
