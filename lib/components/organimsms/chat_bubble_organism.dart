import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_bloc.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_event.dart';
import 'package:recorder/blocs/organisms/chat_bubble/chat_bubble_state.dart';
import 'package:recorder/models/audio.dart';
import 'package:recorder/services/pallete.dart';
import 'package:recorder/services/sound_player.dart';

class ChatBubbleOrganism extends StatefulWidget {
  final Audio audio;
  final SoundPlayer player;

  ChatBubbleOrganism({
    required this.audio,
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  _ChatBubbleOrganismState createState() => _ChatBubbleOrganismState();
}

class _ChatBubbleOrganismState extends State<ChatBubbleOrganism> {
  late ChatBubbleBloc _chatBubbleBloc;

  @override
  void initState() {
    _chatBubbleBloc = ChatBubbleBloc(
      audio: widget.audio,
      player: widget.player,
    );
    _chatBubbleBloc.stopWatchTimer.rawTime.listen((value) {
      _chatBubbleBloc.add(StopWatchTick(value: value));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBubbleBloc>(
      create: (final BuildContext _) {
        return _chatBubbleBloc;
      },
      child: BlocBuilder<ChatBubbleBloc, ChatBubbleState>(
        builder: (
          final BuildContext _,
          final ChatBubbleState state,
        ) {
          return _body(state);
        },
      ),
    );
  }

  Widget _body(final ChatBubbleState state) {
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
                padding: EdgeInsets.only(right: 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (widget.player.isPlaying) {
                          _chatBubbleBloc.add(PauseAudio());
                        } else {
                          if (widget.player.isPaused && _chatBubbleBloc.position != 0) {
                            _chatBubbleBloc.add(ResumeAudio());
                          } else {
                            _chatBubbleBloc.add(PlayAudio());
                          }
                        }
                        setState(() {});
                      },
                      child: Icon(
                        widget.player.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 38,
                        color: Pallete.icon,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    IgnorePointer(
                      child: Stack(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                            ),
                            child: Slider(
                              value: _chatBubbleBloc.position.toDouble(),
                              max: _chatBubbleBloc.duration.toDouble(),
                              activeColor: Pallete.icon,
                              inactiveColor: Pallete.icon.withOpacity(0.5),
                              onChanged: (double) {},
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Text(
                              widget.player.isPlaying
                                  ? _chatBubbleBloc.formattedDuration
                                  : widget.audio.formattedDuration,
                              style: TextStyle(
                                color: Pallete.icon,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
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
                    Text(widget.audio.formattedTime,
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
