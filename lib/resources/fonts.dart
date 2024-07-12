import 'package:flutter/material.dart';

abstract class AppFonts {
  static const TextStyle widgetTitle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'LufgaMedium.ttf',
  );

  static const TextStyle widgetSubtitle = TextStyle(
    fontSize: 12,
    color: Colors.white30,
    fontFamily: 'LufgaRegular.ttf',
  );

  static const TextStyle appBarText = TextStyle(
    fontSize: 18,
    fontFamily: 'LufgaMedium.ttf',
  );

  static const TextStyle milesText = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'LufgaRegular.ttf',
  );

  static const TextStyle chatText = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
  );
}
