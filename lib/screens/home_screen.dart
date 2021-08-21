import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder/blocs/home/home_bloc.dart';
import 'package:recorder/blocs/home/home_event.dart';
import 'package:recorder/blocs/home/home_state.dart';
import 'package:recorder/components/atoms/chat_bubble_atom.dart';
import 'package:recorder/components/atoms/record_atom.dart';
import 'package:recorder/components/atoms/text_field_atom.dart';
import 'package:recorder/services/pallete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _homeBloc.recorder.init();
    _homeBloc.player.init();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.recorder.dispose();
    _homeBloc.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (final BuildContext _) {
        return _homeBloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (
          final BuildContext _,
          final HomeState state,
        ) {
          return SafeArea(
            top: false,
            child: Scaffold(
              appBar: _appBar as PreferredSizeWidget?,
              body: _body(state),
            ),
          );
        },
      ),
    );
  }

  Widget get _appBar {
    return AppBar(
      backgroundColor: Pallete.primary,
      title: Text(
        'What\'s App',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _body(final HomeState state) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            reverse: true,
            children: [
              ..._homeBloc.audioList
                  .map((final String audio) => ChatBubbleAtom(
                        audio: audio,
                        player: _homeBloc.player,
                      ))
                  .toList()
                  .reversed
                  .toList(),
            ],
          ),
        ),
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: _homeBloc.isRecording
                    ? RecordAtom(
                        stopWatchTimer: _homeBloc.stopWatchTimer,
                      )
                    : TextFieldAtom(),
              ),
              SizedBox(
                width: 12,
              ),
              GestureDetector(
                onLongPress: () async {
                  _homeBloc.add(StartRecording());
                },
                onLongPressEnd: (LongPressEndDetails? details) async {
                  _homeBloc.add(StopRecording());
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Pallete.greenLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mic,
                    color: Pallete.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
