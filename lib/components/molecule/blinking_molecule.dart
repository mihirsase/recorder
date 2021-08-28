import 'package:flutter/material.dart';

class BlinkingMolecule extends StatefulWidget {
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;

  const BlinkingMolecule({
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  _BlinkingMoleculeState createState() => _BlinkingMoleculeState();
}

class _BlinkingMoleculeState extends State<BlinkingMolecule> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorAnimation = ColorTween(
      begin: widget.primaryColor,
      end: widget.secondaryColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      setState(() {});
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Icon(
          widget.icon,
          color: _colorAnimation.value,
        );
      },
    );
  }
}
