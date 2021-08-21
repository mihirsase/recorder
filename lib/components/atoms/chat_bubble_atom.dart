import 'package:flutter/material.dart';
import 'package:recorder/services/pallete.dart';

class ChatBubbleAtom extends StatelessWidget {
  final String audio;

  ChatBubbleAtom({
    required this.audio,
  });

  @override
  Widget build(BuildContext context) {
    // final bg = isMe ? Colors.white : Colors.greenAccent.shade100;
    // final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    // final icon = delivered ? Icons.done_all : Icons.done;
    // final radius = isMe
    //     ? BorderRadius.only(
    //         topRight: Radius.circular(5.0),
    //         bottomLeft: Radius.circular(10.0),
    //         bottomRight: Radius.circular(5.0),
    //       )
    //     : BorderRadius.only(
    //         topLeft: Radius.circular(5.0),
    //         bottomLeft: Radius.circular(5.0),
    //         bottomRight: Radius.circular(10.0),
    //       );
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
                    Icon(
                      Icons.play_arrow,
                      size: 38,
                      color: Pallete.icon,
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
