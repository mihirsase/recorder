import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder/blocs/home/home_bloc.dart';
import 'package:recorder/blocs/home/home_event.dart';
import 'package:recorder/blocs/home/home_state.dart';
import 'package:recorder/components/organimsms/chat_bubble_organism.dart';
import 'package:recorder/components/molecule/record_molecule.dart';
import 'package:recorder/components/atoms/text_field_atom.dart';
import 'package:recorder/models/audio.dart';
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
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: _body(state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _appBar {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: Pallete.primary,
      title: Text(
        'Recorder App',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _body(final HomeState state) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView(
            children: [
              ..._homeBloc.audioList
                  .map(
                    (final Audio audio) => ChatBubbleOrganism(
                      key: ValueKey(audio.path),
                      audio: audio,
                      player: _homeBloc.player,
                    ),
                  )
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
                    ? RecordMolecule(
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
