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

  static const TextStyle profileTitleName = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat',
  );

  static const TextStyle profileSubTitleName = TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
    fontFamily: 'Montserrat',
  );

  static const TextStyle loginTitle = TextStyle(
      fontSize: 32,
      color: Color(0xff1A1C1E),
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat-Bold',
      letterSpacing: -1.5);

  static const TextStyle loginSubTitle = TextStyle(
    fontSize: 12,
    color: Color(0xff6C7278),
    height: 1.5,
    fontFamily: 'Montserrat',
  );

  static const TextStyle loginTextFieldTitle = TextStyle(
    fontSize: 12,
    color: Color(0xff6C7278),
    fontFamily: 'Montserrat',
  );
}
