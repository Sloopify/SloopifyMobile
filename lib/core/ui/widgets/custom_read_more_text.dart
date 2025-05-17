// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../managers/color_manager.dart';
import '../../managers/theme_manager.dart';


class CustomReadMoreText extends StatelessWidget {
  final String text;
  final int trimLines;
  final TextStyle? textStyle;
  final Function()? callBackWhenExpandText;
  const CustomReadMoreText({
    Key? key,
    required this.text,
    required this.trimLines,
    this.textStyle,
    this.callBackWhenExpandText

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: trimLines,
      textAlign: TextAlign.justify,
      trimCollapsedText: 'read_more'.tr(),
      trimExpandedText: 'read_less'.tr(),
      style:textStyle?? AppTheme.bodyText3.copyWith(height: 1.7),
      moreStyle: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500,color: ColorManager.primaryColor),
      lessStyle: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500,color: ColorManager.primaryColor),
    );
  }
}
