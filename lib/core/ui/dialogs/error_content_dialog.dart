import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sloopify_mobile/core/managers/color_manager.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/app_gaps.dart';
import '../widgets/custom_elevated_button.dart';

class ErrorContentDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ErrorContentDialog({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Gaps.vGap1,
          CustomElevatedButton(
            backgroundColor: ColorManager.primaryColor,
            icon: const Icon(Icons.replay_outlined),
            onPressed: () {
              onPressed();
              Navigator.of(context).pop();
            },
            label: 'try_again'.tr(),
          )
        ],
      ),
    );
  }
}
