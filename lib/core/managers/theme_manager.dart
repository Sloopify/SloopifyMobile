import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

const poppinsFontFamily = 'Poppins';
const kavoonFontFamily = 'Kavoon';
const kanitFonFamily = 'Kanit';

class AppTheme {
  AppTheme._();

  static ThemeData getApplicationThemeData(BuildContext context) {
    return ThemeData(
      fontFamily: poppinsFontFamily,

      //main Colors
      primaryColor: ColorManager.primaryColor,
      scaffoldBackgroundColor: ColorManager.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ColorManager.primaryColor,
      ),
      splashColor: Colors.transparent,
      //switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return ColorManager.primaryColor;
          }
          return null;
        }),
      ),

      //radio button theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return ColorManager.primaryColor;
          }
          if (states.contains(WidgetState.selected)) {
            return ColorManager.primaryColor;
          }
          return null;
        }),
      ),

      //check box theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return ColorManager.white;
          }
          return null;
        }),
      ),

      // // app bar theme
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        foregroundColor: Colors.black,
        toolbarTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.white,
        ),
        centerTitle: false,
      ),

      // button theme
      // buttonTheme: ButtonThemeData(
      //     shape: const StadiumBorder(),
      //     disabledColor: ColorManager.grey1,
      //     buttonColor: ColorManager.primary,
      //     splashColor: ColorManager.lightPrimary),

      //elevated Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          backgroundColor: ColorManager.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
      ),

      // text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ColorManager.primaryColor),
      ),

      //outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(8),
          foregroundColor: ColorManager.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: const TextStyle().copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: ColorManager.black,
        ),
        bodyMedium: const TextStyle().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorManager.black,
        ),
        bodySmall: const TextStyle().copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: ColorManager.black,
        ),
        labelLarge: const TextStyle().copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: ColorManager.black,
        ),
        labelMedium: const TextStyle().copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: ColorManager.black,
        ),
      ),
      // input decoration theme (text field theme)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        floatingLabelStyle: TextStyle(
          color: ColorManager.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        errorStyle: TextStyle(color: Colors.red),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.black),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),

        // focused border style(primary)
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        // error border style
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),

        // focused border style
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
      ),
    );
  }

  static TextStyle get bodyText1 => TextStyle(
    fontSize: 12,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  static TextStyle get bodyText2 => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorManager.black,
    fontFamily: poppinsFontFamily,
  );

  static TextStyle get bodyText3 => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  // default for Text() widget
  static TextStyle get button => TextStyle(
    fontSize: 14,
    color: ColorManager.black,
    fontWeight: FontWeight.w400,
    fontFamily: poppinsFontFamily,
  );

  static TextStyle get subtitle1 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: poppinsFontFamily,
  ); // default for ListTile(title:) widget style
  static TextStyle get subtitle2 =>
      TextStyle(fontSize: 16, fontFamily: poppinsFontFamily);

  ////////////////////////////////////////////////
  static TextStyle get headline1 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  static TextStyle get headline2 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  static TextStyle get headline3 => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  /////////////////////////////////////////////
  static TextStyle get headline4 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  ///////////////////////////////////////////////
  static TextStyle get headline5 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: poppinsFontFamily,
    color: ColorManager.black,
  );

  ///////////////////////////////////////////////////////
  static TextStyle get headline6 => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: poppinsFontFamily,
    color: ColorManager.primaryColor,
  );

  static TextStyle get header => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: kavoonFontFamily,
    color: ColorManager.black,
  );
}
