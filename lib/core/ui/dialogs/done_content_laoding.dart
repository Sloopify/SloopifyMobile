import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/app_gaps.dart';
import '../../managers/color_manager.dart';

class DoneContentDialog extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function? onPressed;

  const DoneContentDialog({
    Key? key,
    required this.title,
    this.subTitle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: ColorManager.primaryColor,
            size: AppSize.s100,
          ),
          Gaps.vGap2,
          Text(
            textAlign: TextAlign.center,
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700, fontSize: AppFontSize.f14),
          ),
          Gaps.vGap1,
          if (subTitle != null)
            Text(
              textAlign: TextAlign.center,
              '${subTitle}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: AppFontSize.f14,
                  color: ColorManager.black),
            ),
          Gaps.vGap2,

        ],
      ),
    );
  }
}
