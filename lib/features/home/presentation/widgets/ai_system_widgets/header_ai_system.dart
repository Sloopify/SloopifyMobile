import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

import '../../../../../core/managers/color_manager.dart';

class HeaderAiSystem extends StatelessWidget {
  const HeaderAiSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AssetsManager.drawer),
        Gaps.hGap2,
        Text('what are you looking for?',style: AppTheme.header,),
        Spacer(),
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorManager.backGroundGrayLight,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(AssetsManager.user,width: 40,height: 40,),
        )


      ],
    );
  }
}
