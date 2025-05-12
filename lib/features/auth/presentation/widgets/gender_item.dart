import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';

class GenderItem extends StatelessWidget {
  final Gender gender;
  final Gender selectedGender;
  final Function() onSelect;

  const GenderItem({
    super.key,
    required this.gender,
    required this.selectedGender,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: 200,
        height: 200,
        padding: EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              selectedGender == Gender.none
                  ? ColorManager.darkGray
                  : selectedGender == gender
                  ? ColorManager.primaryColor
                  : ColorManager.white,
          border: Border.all(
            color:
                selectedGender != Gender.none
                    ? ColorManager.primaryColor
                    : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              gender == Gender.male ? AssetsManager.male : AssetsManager.female,
              color:
                  selectedGender == Gender.none
                      ? ColorManager.disActive.withOpacity(0.5)
                      : gender == selectedGender
                      ? ColorManager.white
                      : ColorManager.disActive.withOpacity(0.5),
            ),
            Text(
              gender == Gender.male ? "Male" : "Female",
              style: AppTheme.headline3.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color:
                    selectedGender == Gender.none
                        ? ColorManager.disActive.withOpacity(0.5)
                        : selectedGender == gender
                        ? ColorManager.white
                        : ColorManager.disActive.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
