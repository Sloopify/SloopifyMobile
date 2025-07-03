import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

import '../../managers/app_gaps.dart';
import '../../managers/color_manager.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  bool? isError,
  bool? isWarning,
  bool? isSuccess,
  bool? isOffline,
  bool? isImportant,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    snackBarAnimationStyle: AnimationStyle(curve: ElasticInCurve()),
    SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            (isSuccess ?? false)
                ? AssetsManager.successNote
                : (isError ?? false)
                ? AssetsManager.error
                : (isWarning ?? false)
                ? AssetsManager.alert
                : (isOffline ?? false)
                ? AssetsManager.offline
                : (isImportant ?? false)
                ? AssetsManager.important
                : AssetsManager.alert,
          ),
          Gaps.hGap2,
          Expanded(
            child: Text(
              message,
              style: AppTheme.headline4.copyWith(
                color: ColorManager.black,
                fontWeight: FontWeight.w500,
              ),
        maxLines: 1,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      elevation: 2,
      backgroundColor:(isError??false)?ColorManager.lightRed: ColorManager.offWhite,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
