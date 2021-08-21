import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recorder/blocs/home/home_bloc.dart';
import 'package:recorder/blocs/home/home_state.dart';
import 'package:recorder/components/atoms/chat_bubble_atom.dart';
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
    super.initState();
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
              ChatBubbleAtom(audio: 'Test Audio'),
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
                flex: 10,
                child: Container(
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
                        '0:02',
                        style: TextStyle(color: Pallete.icon, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // TextFieldAtom()
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onLongPress: () async {},
                  onLongPressEnd: (LongPressEndDetails? details) async {},
                  child: Container(
                    height: 48,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
