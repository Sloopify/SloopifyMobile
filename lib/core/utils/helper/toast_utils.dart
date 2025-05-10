import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

class ToastUtils {
  static showErrorToastMessage(String message) {
    Fluttertoast.showToast(
        fontAsset:poppinsFontFamily ,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16);
  }

  static showSusToastMessage(String message) {
    Fluttertoast.showToast(
        fontAsset:poppinsFontFamily ,
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16);
  }

  static showWarningToastMessage(String message) {
    Fluttertoast.showToast(
        fontAsset:poppinsFontFamily ,
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16);
  }
}
