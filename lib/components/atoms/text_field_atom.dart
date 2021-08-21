import 'package:flutter/material.dart';
import 'package:recorder/services/pallete.dart';

class TextFieldAtom extends StatelessWidget {
  const TextFieldAtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Pallete.white,
      style: TextStyle(
        color: Pallete.icon,
      ),
      decoration: InputDecoration(
        fillColor: Pallete.primaryLight,
        contentPadding: new EdgeInsets.symmetric(horizontal: 18.0),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.white,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
