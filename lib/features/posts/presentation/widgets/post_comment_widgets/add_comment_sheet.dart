import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';

class AddCommentSheet extends StatelessWidget {
  const AddCommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p20,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: ColorManager.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GeneralImage.circular(radius: 50,isNetworkImage: false,image: AssetsManager.manExample2,),
          Gaps.hGap1,
          Expanded(
            child: CustomTextField(hintText: "write your comment here!"),
          ),
          Gaps.hGap1,

          InkWell(
            onTap: () {},
            child: Text(
              "post",
              style: AppTheme.headline4.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorManager.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
