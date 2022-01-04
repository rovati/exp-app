import 'package:flutter/material.dart';

/// Text styles for the various Text widgets.
class TextStyles {
  static TextStyle white = const TextStyle(color: Colors.white);
  static TextStyle white15 = const TextStyle(color: Colors.white, fontSize: 15);
  static TextStyle white20 = const TextStyle(color: Colors.white, fontSize: 20);
  static TextStyle white20B = const TextStyle(
      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle white30 = const TextStyle(color: Colors.white, fontSize: 30);
  static TextStyle white35 = const TextStyle(color: Colors.white, fontSize: 35);
  static TextStyle white60 = const TextStyle(color: Colors.white, fontSize: 60);

  static TextStyle blueI =
      const TextStyle(color: Colors.blue, fontStyle: FontStyle.italic);
  static TextStyle blue10 = const TextStyle(color: Colors.blue, fontSize: 10);
  static TextStyle blue15 = const TextStyle(color: Colors.blue, fontSize: 15);
  static TextStyle blue20 = const TextStyle(color: Colors.blue, fontSize: 20);
  static TextStyle blue25 = const TextStyle(color: Colors.blue, fontSize: 25);
  static TextStyle blue30 = const TextStyle(color: Colors.blue, fontSize: 30);

  static TextStyle blueU =
      const TextStyle(decoration: TextDecoration.underline, color: Colors.blue);

  static TextStyle lBlue15 =
      TextStyle(color: Colors.blue.shade300, fontSize: 15);
  static TextStyle lBlue20 =
      TextStyle(color: Colors.blue.shade300, fontSize: 20);
  static TextStyle lBlue30 =
      TextStyle(color: Colors.blue.shade300, fontSize: 30);

  static TextStyle red15 = const TextStyle(color: Colors.red, fontSize: 15);
  static TextStyle red20 = const TextStyle(color: Colors.red, fontSize: 20);
  static TextStyle red25 = const TextStyle(color: Colors.red, fontSize: 25);
  static TextStyle red32 = const TextStyle(color: Colors.red, fontSize: 32);
  static TextStyle red35 = const TextStyle(color: Colors.red, fontSize: 35);

  static TextStyle lRed15 = TextStyle(color: Colors.red.shade200, fontSize: 15);
  static TextStyle lRed20 = TextStyle(color: Colors.red.shade200, fontSize: 20);
}
