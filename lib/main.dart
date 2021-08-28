import 'package:flutter/material.dart';
import 'package:recorder/screens/home_screen.dart';

void main() {
  runApp(Recorder());
}

class Recorder extends StatefulWidget {
  const Recorder({Key? key}) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recorder',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: widget!,
        );
      },
      home: HomeScreen(),
    );
  }
}
