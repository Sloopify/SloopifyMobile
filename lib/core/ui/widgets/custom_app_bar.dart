import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/theme_manager.dart';

PreferredSizeWidget getCustomAppBar({
  required BuildContext context,
  Color backGroundColor = Colors.white,
  String title = '',
  bool withArrowBack = true,
  withActions = true,
  Color titleColor = Colors.black,
  Color arrowBackColor = Colors.black,
  bool centerTitle=false,
  final Function()? onArrowBack,
  final List<Widget>? actions,
  PreferredSize ?bottom,
}) {
  final _popupMenu = GlobalKey<PopupMenuButtonState>();
  return AppBar(
    surfaceTintColor: ColorManager.white,
    backgroundColor: backGroundColor,
    leading: withArrowBack
        ? InkWell(
      onTap: () {
        if(onArrowBack!=null)
        {
          onArrowBack();
        }
        Navigator.of(context).pop();
      },
      child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
          ),
          child: Icon(
            Platform.isAndroid
                ? Icons.arrow_back
                : Icons.arrow_back_ios_new,
            color: arrowBackColor,
          )),
    )
        : null,
    actions: withActions
        ? actions
        : [],
    centerTitle: centerTitle,
    title: Text(
      title,
      style: AppTheme.headline2.copyWith(color: titleColor),
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
    ),
    bottom: bottom,
  );
}
