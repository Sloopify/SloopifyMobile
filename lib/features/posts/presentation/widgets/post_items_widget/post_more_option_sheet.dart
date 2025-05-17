import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

import '../../../../../core/managers/app_dimentions.dart';

class PostMoreOptionSheet extends StatelessWidget {
  const PostMoreOptionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p40,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(AssetsManager.share2),
                  ),
                  Text(
                    'share',
                    style: AppTheme.bodyText3.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(AssetsManager.copyLink),
                  ),
                  Text(
                    'Copy link',
                    style: AppTheme.bodyText3.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(AssetsManager.report),
                  ),
                  Text(
                    'Report',
                    style: AppTheme.bodyText3.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: ColorManager.disActive.withOpacity(0.5),
            indent: 20,
            endIndent: 20,
          ),
          Gaps.vGap3,
          InkWell(
            onTap: (){},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AssetsManager.like),
                Gaps.hGap2,
                Text("Add to favourite",style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Gaps.vGap3,
          InkWell(
            onTap: (){},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AssetsManager.hidePost),
                Gaps.hGap2,
                Text("Hide",style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          Gaps.vGap3,

          InkWell(
            onTap: (){},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AssetsManager.deleteFriendship),
                Gaps.hGap2,
                Text("Delete friendship",style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
