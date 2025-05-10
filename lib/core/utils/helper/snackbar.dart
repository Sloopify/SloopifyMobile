import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

import '../../managers/color_manager.dart';

void showSnackBar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      snackBarAnimationStyle: AnimationStyle(curve: ElasticInCurve()),
      SnackBar(
        content: Text(
          message,
          style: AppTheme.headline4.copyWith(color: ColorManager.black),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorManager.white,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(
              color: ColorManager.primaryColor,
              width: 2,
            )),
        duration: const Duration(seconds: 3),
      ));
}
