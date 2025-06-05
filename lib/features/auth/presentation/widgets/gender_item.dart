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
        alignment: Alignment.center,
        width: 250,
        height:  180,
        padding: EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0,2 ),
              color: ColorManager.black.withOpacity(0.25),
              blurRadius: 4,
              spreadRadius: 0
            )
          ],
          color:
             ColorManager.white,
          border: Border.all(
            color:
                selectedGender==gender
                    ? ColorManager.primaryColor
                    : ColorManager.disActive.withOpacity(0.5),
          ),
        ),
        child: SvgPicture.asset(
          gender == Gender.male ? AssetsManager.male : AssetsManager.female,
        ),
      ),
    );
  }
}
