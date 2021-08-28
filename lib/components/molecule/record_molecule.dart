import 'package:flutter/material.dart';
import 'package:recorder/components/molecule/blinking_molecule.dart';
import 'package:recorder/services/pallete.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class RecordMolecule extends StatefulWidget {
  final StopWatchTimer stopWatchTimer;

  const RecordMolecule({
    required this.stopWatchTimer,
  });

  @override
  _RecordMoleculeState createState() => _RecordMoleculeState();
}

class _RecordMoleculeState extends State<RecordMolecule> {
  String _displayTime = '';

  @override
  void initState() {
    widget.stopWatchTimer.rawTime.listen((value) {
      if (mounted)
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
          BlinkingMolecule(
            icon: Icons.mic,
            primaryColor: Pallete.red,
            secondaryColor: Pallete.primaryLight,
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
