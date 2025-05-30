import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_sheet.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_items_widget/post_more_option_sheet.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/color_manager.dart';

class PostPublisherInfo extends StatelessWidget {
  final PostEntity postEntity;

  const PostPublisherInfo({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GeneralImage.circular(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorManager.primaryShade3, ColorManager.primaryShade4],
            ),
            shape: BoxShape.circle,
            border: Border.all(color: ColorManager.primaryColor, width: 2),
          ),
          radius: 50,
          isNetworkImage: false,
          image: postEntity.profileImage,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postEntity.publisherName,
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "10 Apr 2025",
                    style: AppTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  Gaps.hGap1,
                  if (postEntity.location != null)
                    Text(
                      postEntity.location!,
                      style: AppTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            CustomSheet.show(
              child: PostMoreOptionSheet(postEntity: postEntity),
              context: context,
              barrierColor: ColorManager.black.withOpacity(0.2),
            );
          },
          child: SvgPicture.asset(AssetsManager.postInfo),
        ),
      ],
    );
  }
}
