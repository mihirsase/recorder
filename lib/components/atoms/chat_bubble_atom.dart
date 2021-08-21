import 'package:flutter/material.dart';
import 'package:recorder/services/pallete.dart';
import 'package:recorder/services/sound_player.dart';

class ChatBubbleAtom extends StatefulWidget {
  final String audio;
  final SoundPlayer player;

  ChatBubbleAtom({
    required this.audio,
    required this.player,
  });

  @override
  _ChatBubbleAtomState createState() => _ChatBubbleAtomState();
}

class _ChatBubbleAtomState extends State<ChatBubbleAtom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
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
                      onTap: () {
                        if (widget.player.isPlaying) {
                          widget.player.pause();
                        } else {
                          widget.player.play(widget.audio);
                        }
                        setState(() {});
                      },
                      child: Icon(
                        widget.player.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 38,
                        color: Pallete.icon,
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
