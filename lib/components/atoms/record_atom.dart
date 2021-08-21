import 'package:flutter/material.dart';
import 'package:recorder/services/pallete.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class RecordAtom extends StatefulWidget {
  final StopWatchTimer stopWatchTimer;

  const RecordAtom({
    required this.stopWatchTimer,
  });

  @override
  _RecordAtomState createState() => _RecordAtomState();
}

class _RecordAtomState extends State<RecordAtom> {
  String _displayTime = '';

  @override
  void initState() {
    widget.stopWatchTimer.rawTime.listen((value) {
      setState(() {
        _displayTime = StopWatchTimer.getDisplayTime(
          value,
          hours: false,
          milliSecond: false,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      height: 48,
      decoration: BoxDecoration(
        color: Pallete.primaryLight,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.mic,
            color: Pallete.red,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            _displayTime,
            style: TextStyle(color: Pallete.icon, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
