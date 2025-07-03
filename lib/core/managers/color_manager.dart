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
static const Color bottomNavigationBackGround=Color(0xff14B8A6);
static const Color deepPrimaryColor=Color(0xff115E59);
static const Color primaryShade1=Color(0xff14B8A6);
static const Color primaryShade2=Color(0xff2DD4BF);
static const Color primaryShade3=Color(0xff5EEAD4);
static const Color primaryShade4=Color(0xff0D9488);
static const Color lightGrayShade1=Color(0xffECF0F1);
static const Color textGray1=Color(0xff5D6778);
static const Color textBlue=Color(0xff004182);
static const Color gray600=Color(0xff475569);
static const Color red=Color(0xffFF0000);
static const Color green=Color(0xff00FF00);
static const Color yellow=Color(0xffFFFF00);
static const Color blue=Color(0xff0000FF);
static const Color redWithGradiant=Color(0xffD75151);
static const Color blueWithGradiant=Color(0xff433E7B);
static const Color textGray3=Color(0xff727171);
static const Color offWhite=Color(0xffEDEFF1);
static const Color lightRed=Color(0xffFECDD3);


  static final gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.black, Color(0xff4A4A4A)],
  );
static final backGroundTextWidget = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [redWithGradiant, blueWithGradiant],
);
}
