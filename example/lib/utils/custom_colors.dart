import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  static const Color transparent = Color(0x00000000);

  static const Color primaryButton = Color(0xff8247E5);

  static const Color primaryButtonText = Color(0xffFFFFFF);

  static const Color secondaryButton = Color(0xff2C374E);

  static const Color secondaryButtonText = Color(0xff2C374E);

  static const Color subtitleText = Color(0xff7C7E96);

  static const Color background = Color(0xffF0F1F6);

  static const Color textGrayDark = Color(0xff2C374E);

  static const Color redError = Color(0xffFF4B40);

  static const Color greenSuccess = Color(0xff1BC44B);

  static const Color backButtonPressed = Color(0xffE1E1E1);

  static const Color proofCardSubtitle = Color(0xffEBEDF3);

  static const int _whitePrimaryValue = 0xFFFFFFFF;
  static const MaterialColor primaryWhite = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(_whitePrimaryValue),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  static const int _orangePrimaryValue = 0xffffa600;
  static const MaterialColor primaryOrange = MaterialColor(
    _orangePrimaryValue,
    <int, Color>{
      50: Color(0xffffa600),
      100: Color(0xffffa600),
      200: Color(0xffffa600),
      300: Color(0xffffa600),
      400: Color(0xffffa600),
      500: Color(_orangePrimaryValue),
      600: Color(0xffffa600),
      700: Color(0xffffa600),
      800: Color(0xffffa600),
      900: Color(0xffffa600),
    },
  );

  static const Color claimCardStartColor = Color(0xff7B3FE4);
  static const Color claimCardEndColor = Color(0xff5D12E1);

  static const LinearGradient claimCardBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      claimCardStartColor,
      claimCardEndColor,
    ],
  );
}
