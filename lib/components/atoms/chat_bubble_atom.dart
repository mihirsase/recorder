import 'package:flutter/material.dart';
import 'package:recorder/services/pallete.dart';
import 'package:recorder/services/sound_player.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChatBubbleAtom extends StatefulWidget {
  final String audio;
  final SoundPlayer player;

  ChatBubbleAtom({
    required this.audio,
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  _ChatBubbleAtomState createState() => _ChatBubbleAtomState();
}

class _ChatBubbleAtomState extends State<ChatBubbleAtom> {
  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );
  int position = 0;
  int duration = 0;

  @override
  void initState() {
    stopWatchTimer.rawTime.listen((value) {
      setState(() {
        position = (duration - value).isNegative ? 0 : duration - value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: .5, spreadRadius: 1.0, color: Colors.black.withOpacity(.12))
            ],
            color: Pallete.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (widget.player.isPlaying) {
                          widget.player.stop();
                          stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                          position = 0;
                        } else {
                          Duration? d = await widget.player.play(widget.audio, () {
                            stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                            position = 0;
                            setState(() {});
                          });
                          duration = d!.inMilliseconds;
                          stopWatchTimer.setPresetSecondTime(d.inSeconds);
                          stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        }
                        setState(() {});
                      },
                      child: Icon(
                        widget.player.isPlaying ? Icons.stop : Icons.play_arrow,
                        size: 38,
                        color: Pallete.icon,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    IgnorePointer(
                      child: Slider(
                        value: position.toDouble(),
                        max: duration.toDouble(),
                        onChanged: (double) {},
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text('10:04 PM',
                        style: TextStyle(
                          color: Pallete.icon,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      Icons.done_all,
                      size: 18.0,
                      color: Pallete.icon,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
