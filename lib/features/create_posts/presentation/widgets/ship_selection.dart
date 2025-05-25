import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

class ShipSelection extends StatelessWidget {
  final String text;
  final String svgAssets;
  final Function() onTap;
  const ShipSelection({super.key,required this.onTap,required this.text,required this.svgAssets});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p4,vertical: AppPadding.p2),
        margin: EdgeInsets.symmetric(horizontal: AppPadding.p4),
        decoration: BoxDecoration(
          color: ColorManager.primaryShade1.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svgAssets),
            Gaps.hGap1,
            Text(text,style: AppTheme.bodyText3.copyWith(color: ColorManager.primaryColor,fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  }
}
