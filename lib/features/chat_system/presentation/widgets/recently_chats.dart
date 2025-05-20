import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';

class RecentlyChats extends StatelessWidget {
  const RecentlyChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap2,
        Text("Recently",style: AppTheme.headline4.copyWith(fontWeight: FontWeight.bold),),
        Gaps.vGap2,
        SizedBox(
          height: 55,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GeneralImage.circular(
                fit: BoxFit.cover,
                isNetworkImage: false,
                image: AssetsManager.manExample,
                radius: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(4, 0),
                      spreadRadius: 0,
                      blurRadius: 4,
                      color: ColorManager.black.withOpacity(0.25)
                    )
                  ],
                    border: Border.all(
                    color: ColorManager.primaryColor, width: 1.5)),);
            },
            separatorBuilder: (context, index) {
              return Gaps.hGap2;
            },
            itemCount: 20,
          ),
        ),
      ],
    );
  }
}
