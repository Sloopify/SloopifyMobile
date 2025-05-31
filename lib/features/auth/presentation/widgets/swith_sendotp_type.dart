import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';

import '../../../../core/managers/app_dimentions.dart';

class SwitchSendOtpType extends StatelessWidget {
  final OtpSendType otpSendType;
  final bool isSelected;
  final Function() onChanged;

  const SwitchSendOtpType({super.key, required this.otpSendType,required this.isSelected,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        onChanged();
      },
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: AppPadding.p10),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primaryColor :Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            otpSendType==OtpSendType.email?"E-mail": "Mobile",
            style: AppTheme.bodyText3.copyWith(
              color:isSelected ? ColorManager.white :ColorManager.disActive.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
