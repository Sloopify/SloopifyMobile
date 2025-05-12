import 'package:flutter/material.dart';

class ColorManager {

static const Color white =Colors.white;
static const Color black =Colors.black;
static const Color primaryColor =Color(0xff14B8A6);
static const Color disActive =Color(0xff595858);
static const Color lightGray =Color(0xffD9D9D9);
static const Color textGray =Color(0xffB2A9A9);
static const Color darkGray =Color(0xffD1D5DB);
static const Color backGroundGrayLight =Color(0xffD9D9D9);
static const Color backGroundGray =Color(0xff263238);

  static final gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.black, Color(0xff4A4A4A)],
  );
}
