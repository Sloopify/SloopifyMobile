import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';

class AskRobotWidget extends StatelessWidget {
  const AskRobotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
            width: MediaQuery.of(context).size.height * 0.3,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: ColorManager.lightGrayShade1,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(4, 8),
                ),
                BoxShadow(
                  color: ColorManager.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    'Ask me any thing you want',
                    style: AppTheme.headline2.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
                Gaps.vGap1,
                SizedBox(
                  height: 40,
                  child: CustomElevatedButton(
                    width: MediaQuery.of(context).size.width*0.35,
                    padding: EdgeInsets.zero,
                    label: "start chat",
                    onPressed: () {},
                    backgroundColor: ColorManager.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          AssetsManager.cartoon,
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.height * 0.25,
          alignment: Alignment.topLeft,
        ),
      ],
    );
  }
}
